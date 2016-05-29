///TMCT_RemoveGesture(GestureName)
/*
Removes a gesture from the Gesture List

GestureName string, the gesture to remove

Note: this is slow
*/

var size = ds_map_size(global.TMCT_gestures);
if(size)
{
    var newmap = ds_map_create();
    var key = ds_map_find_first(global.TMCT_gestures);
    var value;
    for (var i = 0; i < size; i++;)
    {
        value = ds_map_find_value(global.TMCT_gestures,key)
        if (value !=  argument0)
        {
             ds_map_add(newmap,key,value);
        }
        key = ds_map_find_next(global.TMCT_gestures, key);
    
    }
    ds_map_destroy(global.TMCT_gestures);
    global.TMCT_gestures = newmap;
    
}
 
