///TMCT_DeviceDataCount(device)
/*
Get the numver of items in the device data
device index, the device index 0,1,2,3
device data is 
xy item 0 (first touch)
dxdy item 1
xy item 2
dydy item 3
...
lastxy (last; release)
*/
return ds_list_size(global.TMCT_dev[argument0]) /2;
