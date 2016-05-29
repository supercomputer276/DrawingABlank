///TMCT_AddGesture(GestureName,GestureSegments,multiple)
/*
1.0.3 origninal MCT_AddGesture(GestureName,GestureSegments,reversable,multiple)
1.1.0 changes:
---reversable bool, if the gesture can be drawn in both direction
you will get 
Error : LOCATION : function "TMCT_AddGesture" expects 3 arguments, 4 provided
if you update the asset. You need to remove this 3rd argument from your calls in your code

this option has been removed in 1.1.0. it was implemented wrong and as it turns out it is not possible to automate this as the directional segments cannot 
simply be revesed but needs to be re-defined as a separate set of segment characters. 

It was pure luck that the original demo tricked me into thinking reversing the string worked because for the 
square and the circle definition refersing the string does reverse the shape, but that is not the case for most shapes.

if you want the shape to be reversably drawn you must add another shape of the same name with the proper directional segments


you will need to change this for example in 1.0.3
TMCT_AddGesture("CIRCLE","45670123",true,true); //A counter clockwize definition
to this
TMCT_AddGesture("CIRCLE","45670123",true); //A counter clockwize definition
TMCT_AddGesture("CIRCLE","07654321",true); //A clockwize definition

Also the multiple option was broken, generating a variable number of differentlenght string intead of a variable numeber of same shape sring for the segment

example for a square 0642
it would generate
0642
064
06
0
instead of 
0642
6420
4206
2064


/*
Adds a Gesture to the Gesture List

GestureName string, the name for the gesture. You can have many gestures with the same name to cover multiple methods or direcions
GestureSegments string, a combination of segments from 0 to N, see TMCT_SetNumAngleSegments for the last possible segment value


multiple bool, if the gesture can be started from any point, for example a circle can be started from the top or bottom

TMCT_AddGesture("CIRCLE","45670123",true);
TMCT_AddGesture("SQUARE","0642",true);
TMCT_AddGesture("RIGHT","0",false);
TMCT_AddGesture("LEFT","4",false);
TMCT_AddGesture("UP","2",false);
TMCT_AddGesture("DOWN","6",false);

*/
var s = argument1;
ds_map_add(global.TMCT_gestures, s,argument0);
show_debug_message(argument0 + " orig  = " + s);
if(argument2)
{
    var slen = string_length(s);
    //for the size or the string -1,
    for(i = 0; i < slen-1; i++)
    {
        //copy the first char
        var c1 = string_copy(s,1,1);
        //copy the rest of the string, - first char and append first char to the end
        s = string_copy(s,2,slen-1) + c1;
        //this will iterate through every possibility, aside the very first option which was handled outside the loop
        
        ds_map_add(global.TMCT_gestures, s,argument0);
        show_debug_message(argument0 + " mult " + string(i+1) +" = " + s);
    }
}
/*
1.0.3 buggy code
var s = argument1;
ds_map_add(global.TMCT_gestures, s,argument0);
show_debug_message(argument0 + " " + s);
if(argument3)
{
    
    var l = string_length(s);
    var c;
    repeat(l-1)
    {
        c = string_copy(s,1,1);
        s = string_copy(s,2,l) + c;
        ds_map_add(global.TMCT_gestures, s,argument0);
        show_debug_message(argument0 + " " + s);
    }
}
if(argument2)
{
    s = ""
    var l = string_length(argument1);
    var i;
    for (i = l; i>0; i--)
    {
        s += string_copy(argument1,i,1);
    }
    ds_map_add(global.TMCT_gestures, s,argument0);
    show_debug_message(argument0 + " MULT " + s);
    if(argument3)
    {
        
        var l = string_length(s);
        var c;
        repeat(l-1)
        {
            c = string_copy(s,1,1);
            s = string_copy(s,2,l) + c;
            ds_map_add(global.TMCT_gestures, s,argument0);
            show_debug_message(argument0 + " " + s);
        }
    }
}
*/
