///drawing_test_circle()
/*
    Test the layout of the player's drawing to determine if it is a CIRCLE.
    This is done by sampling different points of the drawing to produce test circles,
    and the whole drawing is determined to be a circle if these test circles average
    out to be very similar to each other.
*/
if(!instance_exists(obj_drawmark) || ds_list_size(drawing) < 3) return false;

//assemble test circles
var TEST_NUMBER = 4, //number of test circles to make
    num = ds_list_size(drawing);
var testCircles; testCircles[TEST_NUMBER-1,2] = 0;
// testCircles[x,?] - test circle number x
// testCircles[x,0] - x-coordinate of center
// testCircles[x,1] - y-coordinate of center
// testCircles[x,2] - radius of center
var third = num / 3;
show_debug_message("-- BEGIN TEST CIRCLE CALCULATION --");
for(var c = 0; c < TEST_NUMBER; c++) {
    show_debug_message("Circle #" + string(c));
    //get points to test with
    var point1 = round(third*(c / TEST_NUMBER));
    var point2 = round(point1 + third);
    var point3 = round(point2 + third);
    var i = ds_list_find_value(drawing,point1),
        j = ds_list_find_value(drawing,point2),
        k = ds_list_find_value(drawing,point3);
    show_debug_message("i(" + string(i.x) + "," + string(i.y) + ") "
        + "j(" + string(j.x) + "," + string(j.y) + ") "
        + "k(" + string(k.x) + "," + string(k.y) + ")");
    //find center
    var delta = ((k.x-j.x)*(j.y-i.y))
        -((j.x-i.x)*(k.y-j.y));
    show_debug_message("delta = " + string(delta));
    if(delta == 0) {
        //cannot determine a circle from this, as the coordinates are aligned
        //if this occurs, since the dots are spaced out to attempt an equilateral
        // triangle, it's impossible for this to be a circle
        return false;
    }
    testCircles[c,0] = abs((((k.y-j.y)*(power(i.x,2)+power(i.y,2)))
        + ((i.y-k.y)*(power(j.x,2)+power(j.y,2)))
        + ((j.y-i.y)*(power(k.x,2)+power(k.y,2))))
        / (2 * delta));
    testCircles[c,1] = abs((((k.x-j.x)*(power(i.x,2)+power(i.y,2)))
        + ((i.x-k.x)*(power(j.x,2)+power(j.y,2)))
        + ((j.x-i.x)*(power(k.x,2)+power(k.y,2))))
        / (2 * delta));
    show_debug_message("C(" + string(testCircles[c,0]) + ","
        + string(testCircles[c,1]) + ")");
    //check directions to points to ensure a general loop shape
    /*var angles, angleDifference, angleGuideline = 120, angleError = 35;
    angles[2] = point_direction(testCircles[c,0],testCircles[c,1],k.x,k.y);
    angles[1] = point_direction(testCircles[c,0],testCircles[c,1],j.x,j.y);
    angles[0] = point_direction(testCircles[c,0],testCircles[c,1],i.x,i.y);
    show_debug_message("angles i(" + string(angles[0])
         + ") j(" + string(angles[1]) + ")");
    angleDifference[1] = abs(angle_difference(angles[1],angles[2]));
    angleDifference[0] = abs(angle_difference(angles[0],angles[1]));
    show_debug_message("difference i=" + string(angleDifference[0]) + " (" + string(angle_difference(angleDifference[0],angleGuideline)) + ")"
         + " j=" + string(angleDifference[1]) + " (" + string(angle_difference(angleDifference[1],angleGuideline)) + ")"
         + " -> " + string(angleDifference[0] + angleDifference[1]));
    for(var it = 0; it < 2; it++) {
        if(angleDifference[it] < angleGuideline - angleError
            || angleDifference[it] > angleGuideline + angleError)
            return false; //probably not a loop
    }*/
    //find radius
    testCircles[c,2] = point_distance(testCircles[c,0],testCircles[c,1],
        i.x,i.y);
    show_debug_message("radius = " + string(testCircles[c,2]));
    //DEBUG: show circles
    /*var myDisplay = instance_create(testCircles[c,0],testCircles[c,1],obj_debug_circle);
    myDisplay.r = testCircles[c,2];
    myDisplay.c = make_colour_hsv(0,0,c*(255/16));*/
}
//find the average circle of the test circles
var averageCircle;
for(var i = 2; i >= 0; i--) {
    averageCircle[i] = 0;
    for(var c = 0; c < TEST_NUMBER; c++) {
        averageCircle[i] += testCircles[c,i];
    }
    averageCircle[i] /= TEST_NUMBER;
}
show_debug_message("AVERAGE C(" + string(averageCircle[0]) + ","
    + string(averageCircle[1]) + ") radius = " + string(averageCircle[2]));
/*var averageDisplay = instance_create(averageCircle[0],
    averageCircle[1],obj_debug_circle);
averageDisplay.r = averageCircle[2];
averageDisplay.c = c_red;*/
//test if all circles lie within 1 standard deviation or so; return true if all do
var standDev;
for(var i = 2; i >= 0; i--) {
    standDev[i] = 0;
    for(var c = 0; c < TEST_NUMBER; c++) {
        standDev[i] += power(testCircles[c,i]-averageCircle[i],2);
    }
    standDev[i] = sqrt(standDev[i] / TEST_NUMBER);
}
show_debug_message("standard deviation C(" + string(standDev[0]) + ","
    + string(standDev[1]) + ") radius = " + string(standDev[2]));
var mult = 1.75;
/*var originBoundary = instance_create(averageCircle[0],averageCircle[1],
    obj_debug_ellipse);
originBoundary.w = standDev[0]*mult;
originBoundary.h = standDev[1]*mult;
originBoundary.c = c_lime;
var radiusBoundaryInner = instance_create(averageCircle[0],averageCircle[1],
    obj_debug_circle);
radiusBoundaryInner.r = averageCircle[2]-(standDev[2]*mult);
radiusBoundaryInner.c = c_lime;
var radiusBoundaryOuter = instance_create(averageCircle[0],averageCircle[1],
    obj_debug_circle);
radiusBoundaryOuter.r = averageCircle[2]+(standDev[2]*mult);
radiusBoundaryOuter.c = c_lime;*/
//check test circles
var count = 0, total = TEST_NUMBER * 3;
for(var c = 0; c < TEST_NUMBER; c++) {
    //check center
    if((power(testCircles[c,0]-averageCircle[0],2)
        / power(standDev[0] * mult,2))
        + (power(testCircles[c,1]-averageCircle[1],2)
        / power(standDev[1] * mult,2)) <= 1)
        count += 2;
    //check radius
    if(testCircles[c,2] >= averageCircle[2]-(standDev[2]*mult)
        && testCircles[c,2] <= averageCircle[2]+(standDev[2]*mult))
        count++;
}
show_debug_message("points scored: " + string(count)
    + " / " + string(total)
    + " (" + string(count / total * 100) + "%)")
var pass = count / total >= 0.75;
if(pass) {
    //store details of the average circle for recall object
    recallCircleX = averageCircle[0];
    recallCircleY = averageCircle[1];
    recallCircleRadius = averageCircle[2];
}
return pass;
/*//check dots
var count = 0;
for(var d = 0; d < num; d++) {
    var dot = instance_find(obj_drawmark,d);
    var dist = point_distance(averageCircle[0],averageCircle[1],dot.x,dot.y);
    if(dist < averageCircle[2]-(standDev[2]*mult)
        || dist > averageCircle[2]+(standDev[2]*mult))
        count++;
}
show_debug_message("Dots out of Goldilocks: " + string(count)
    + " / " + string(num) + " (" + string(count / num * 100) + "%)");
return count < num * 0.1;*/
