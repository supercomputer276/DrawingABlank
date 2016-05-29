///TMCT_DeviceGetDataLastDXDY(device)
/*
Get the last dxdy of the data for the device

device index, the device index 0,1,2,3

returns a 2 item array with dx,dy
*/


var dxdy;
dxdy[0] = 0;
dxdy[1] = 0;

var ct = TMCT_DeviceDataCount(argument0)
if(ct>1)
{
    dxdy = TMCT_DeviceGetData(argument0,ct-2);
}
return dxdy;
