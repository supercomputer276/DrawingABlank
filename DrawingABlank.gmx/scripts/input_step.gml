///input_step()
/*
    Performs special operations relating to input every step.
    Namely, keeps track of axes to see when they switch between 0 and not-0
        for the purpose of faking "pressed" and "released" functionality on them.
*/
//assemble sections to check
var checklist; checklist[2,2] = 0;
//flag to check     horizontal axis    vertical axis    whether to negate condition
checklist[0,0] = input.move_analog;
checklist[0,1] = input.move_left;
checklist[0,2] = input.move_up;
checklist[0,3] = false;

checklist[1,0] = input.brush_mouse;
checklist[1,1] = input.brush_moveh;
checklist[1,2] = input.brush_movev;
checklist[1,3] = true;

checklist[2,0] = input.brush_flickmouse;
checklist[2,1] = input.brush_flickh;
checklist[2,2] = input.brush_flickv;
checklist[2,3] = true;

for(var i = 0; i < array_height_2d(checklist); i++) {
    var conditional = input_get(checklist[i,0]);
    if(checklist[i,3]) conditional = !conditional;
    if(conditional) {
        var currH = input_axis(checklist[i,1]), currV = input_axis(checklist[i,2]),
            pastH = analogState[? checklist[i,2]], pastV = analogState[? checklist[i,2]];
        //show_debug_message(string(pastH) + " <> " + string(currH)
        //    + " | " + string(pastV) + " <> " + string(currV));
        analogPressed[? checklist[i,1]] = currH != 0 && pastH == 0;
        analogReleased[? checklist[i,1]] = currH == 0 && pastH != 0;
        analogPressed[? checklist[i,2]] = currV != 0 && pastV == 0;
        analogReleased[? checklist[i,2]] = currV == 0 && pastV != 0;
        //update state
        analogState[? checklist[i,1]] = currH;
        analogState[? checklist[i,2]] = currV;
    }
}
