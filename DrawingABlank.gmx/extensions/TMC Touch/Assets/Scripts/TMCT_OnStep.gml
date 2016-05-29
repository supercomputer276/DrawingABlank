///TMCT_OnStep()
/*
Call every step by your controller. it may be a good idea to call this in the draw event
where the mouse coords are in line with the view coords
*/
var i,j,xx,yy,xy,dx,dy,detectxy;
for(i = 0; i<4; i++)
{
    if(device_mouse_check_button_pressed(i,mb_any))
    {
        TMCT_ClearSegment(i);
        TMCT_ClearDeviceData(i);
        TMCT_ClearLastGesture(i);
        TMCT_AddDeviceData(i,device_mouse_raw_x(i),device_mouse_raw_y(i));
        global.TMCT_lastp[i] = 0;
    }
    else if(device_mouse_check_button(i,mb_any))
    {
        var ct = TMCT_DeviceDataCount(i);
        if(ct)
        {
            xx = device_mouse_raw_x(i);
            yy = device_mouse_raw_y(i);
            xy = TMCT_DeviceGetData(i,ct-1);
            if(point_distance(xx,yy,xy[0],xy[1])> global.TMCT_DetectRange)
            {
                //dx=0;
                //dy=0;
                //for(j=global.TMCT_lastp[i]+1; j<ct; j+=2)
                //{
                //    xy = TMCT_DeviceGetData(i,j);
                //    dx+=xy[0];
                //    dy+=xy[1];
                //    draw_circle_colour(xy[0],xy[1],global.TMCT_ChangeRange,c_lime,c_lime,1);
                //}
                //for(j=global.TMCT_lastp[i]; j<=ct; j+=2)
                //{
                //    xy = TMCT_DeviceGetData(i,j);
                //    draw_circle_colour(xy[0],xy[1],global.TMCT_ChangeRange,c_lime,c_lime,1);
                //    draw_set_color(c_lime);
                //    draw_arrow(xy[0],xy[1],xy[0]+dx,xy[1]+dy,10);
                //    draw_set_color(c_black);
                //}
                //var xystart = TMCT_DeviceGetData(i,0);
                xy = TMCT_DeviceGetData(i,global.TMCT_lastp[i]);
                
                if(point_distance(xy[0],xy[1],xx,yy)>=global.TMCT_ChangeRange)
                {
                    xy = TMCT_DeviceGetData(i,ct-1);
                    var dir = point_direction(xy[0],xy[1],xx,yy);
                    var segmentd = floor(((dir+180/global.TMCT_AnglesSegments) mod 360)/(360/global.TMCT_AnglesSegments))
                    TMCT_AddSegment(i,segmentd);
                    global.TMCT_lastp[i] = ct+1;
                
                    
                }
                xy = TMCT_DeviceGetData(i,ct-1);
                TMCT_AddDeviceData(i,xx-xy[0],yy-xy[1]);
                TMCT_AddDeviceData(i,xx,yy);
            }
            
        }
        
    }
    
}
