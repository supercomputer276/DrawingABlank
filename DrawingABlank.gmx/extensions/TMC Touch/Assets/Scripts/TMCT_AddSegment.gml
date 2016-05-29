///TMCT_AddSegment(device,segment)
/*
Adds the gesture segment string for the device

device index, the device index 0,1,2,3
segment real, the angle converted to a segment number 0,1,2,3,4,5,6,7

Called internally
*/
var c = string(argument1);
global.TMCT_segments[argument0] += c;
//nuke duplicates
global.TMCT_segments[argument0] = string_replace_all(global.TMCT_segments[argument0],c+c,c);
