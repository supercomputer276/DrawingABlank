///TMCT_SetDeviceGesture(device, TMCT_SetDeviceGesture)
/*
Gets the current gesture name detected on the device
Sets the last Gesture if the new gesture is not blank

device index, the device index 0,1,2,3
gesture, the decoded gesture name

*/
if(argument1!="") global.TMCT_lastGestures[argument0] = argument1;
global.TMCT_currentGestures[argument0] = argument1;
