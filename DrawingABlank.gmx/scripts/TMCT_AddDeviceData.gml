///TMCT_AddDeviceData(device,x,y)
/*
Adds a coord to the device. Called internally

device index, the device index 0,1,2,3

x, real, the device coord
y, real, the device coord

or
dx, real, the device movement
dy, real, the device movement

*/
//well looks like studio supports multiple add in one go!
ds_list_add(global.TMCT_dev[argument0],argument1,argument2);
