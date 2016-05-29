///TMCT_SegmentToGestureName(segment)
/*
Reurns the GestureName from the segment string or ""
*/

if(ds_map_exists(global.TMCT_gestures,argument0))
{
    return(ds_map_find_value(global.TMCT_gestures,argument0))
}
return "";
