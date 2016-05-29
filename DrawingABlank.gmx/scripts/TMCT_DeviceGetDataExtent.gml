///TMCT_DeviceGetDataExtent(device)
/*
Get the entent (left,top,right,bottom) of the data for the device

device index, the device index 0,1,2,3

returns a 4 item array with left,top,right,bottom
*/


var ltrb,l,r,t,b,xy;
l = 9999999999;
r = -9999999999;
t = 9999999999;
b = -9999999999;
ltrb[0] = 0;
ltrb[1] = 0;
ltrb[2] = 0;
ltrb[3] = 0;
var ct = TMCT_DeviceDataCount(argument0)
var i;
if(ct)
{
    for(i = 0; i < ct; i+=2)
    {
        xy = TMCT_DeviceGetData(argument0,i);
        if(xy[0]<l) l = xy[0]
        if(xy[0]>r) r = xy[0]
        if(xy[1]<t) t = xy[1]
        if(xy[1]>b) b = xy[1]
    }
    ltrb[0] = l;
    ltrb[1] = t;
    ltrb[2] = r;
    ltrb[3] = b;
}
return ltrb;
