///TMCT_ClearAllDevicesData()
/*
Clears all the devices (0,1,2,3) data accumulated during a gesture

device data is 
xy item 0 (first touch)
dxdy item 1 delta from first to next
xy item 2 next point
dydy item 3 delta from above point to next
...
lastdydy at count -2
lastxy (last; release at count -1)

*/

TMCT_ClearDeviceData(0);
TMCT_ClearDeviceData(1);
TMCT_ClearDeviceData(2);
TMCT_ClearDeviceData(3);
