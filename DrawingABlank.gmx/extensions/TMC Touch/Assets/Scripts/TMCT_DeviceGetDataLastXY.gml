///TMCT_DeviceGetDataLastXY(device)
/*
Get the last xy of the data for the device

device index, the device index 0,1,2,3

returns a 2 item array with x,y
*/


var xy;
xy[0] = 0;
xy[1] = 0;


var ct = TMCT_DeviceDataCount(argument0)

if(ct)
{
    xy = TMCT_DeviceGetData(argument0,ct-1);
}
return xy;
