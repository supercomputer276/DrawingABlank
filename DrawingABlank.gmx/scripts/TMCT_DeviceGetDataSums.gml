///TMCT_DeviceGetDataSums(device)
/*
Get the sum (sum of x,y,dx,dy) of the data for the device

sum x y is somewhat pointeless but the sum dx dy can be uselful

device index, the device index 0,1,2,3

returns a 4 item array with x,y,dx,dy sums
*/


var xydxdy, count;
xydxdy[0] = 0;
xydxdy[1] = 0;
xydxdy[2] = 0;
xydxdy[3] = 0;
count = 0;
var ct = TMCT_DeviceDataCount(argument0)
var i;
if(ct)
{
    count = 0;
    for(i = 0; i < ct; i+=2)
    {
        xy = TMCT_DeviceGetData(argument0,i);
        if(i == 0)
        {
            xydxdy[0] = xy[0];
            xydxdy[1] = xy[1];
        }
        else
        {
            xydxdy[0] += xy[0];
            xydxdy[1] += xy[1];
        }
        count++;
    }
    //xydxdy[0] /= count;
    //xydxdy[1] /= count;
    count = 0;
    for(i = 1; i < ct; i+=2)
    {
        xy = TMCT_DeviceGetData(argument0,i);
        if(i == 0)
        {
            xydxdy[2] = xy[0];
            xydxdy[3] = xy[1];
        }
        else
        {
            xydxdy[2] += xy[0];
            xydxdy[3] += xy[1];
        }
        count++;
    }
    //xydxdy[2] /= count;
    //xydxdy[3] /= count;
}
return xydxdy;
