///TMCT_DeviceGetData(device,pos)
/*
Get the numver of items in the device data
device index, the device index 0,1,2,3
pos, real, the data position
*/
//well looks like studio supports multiple add in one go!
var xy;
xy[0] = ds_list_find_value(global.TMCT_dev[argument0],argument1*2);
xy[1] = ds_list_find_value(global.TMCT_dev[argument0],argument1*2+1);
return xy;
