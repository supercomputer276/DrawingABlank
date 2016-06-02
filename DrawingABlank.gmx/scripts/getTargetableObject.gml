///getTargetableObject(index,fulltargets)
/*
    Returns the object index at the index in the given list.
    Returns noone if something goes wrong.
    
    argument0 - int - the index of the entry to get (that doesn't include the void counts)
    argument1 - boolean - check empty (false) or full (true) targetable list
    returns - id - object ID at the index in the list
*/
var list;
if(argument1) list = targetFullList;
else list = targetEmptyList;

var ind = argument0 * 2;
if(ind >= ds_list_size(list)) return noone;
return ds_list_find_value(list,ind);
