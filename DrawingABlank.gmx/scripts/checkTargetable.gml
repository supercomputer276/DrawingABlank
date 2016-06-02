///checkTargetable(instance,fulltargets)
/*
    Check whether or not the given instnace is targetable with Void.
    
    argument0 - id - instance to determine the targetability of
    argument1 - boolean - check empty (false) or full (true) targetable list
    returns - boolean - if the instance is targetable
*/
var obj = argument0.object_index;
var list;
if(argument1) list = targetFullList;
else list = targetEmptyList;
for(var ind = 0; ind < ds_list_size(list); ind += 2) {
    if(ds_list_find_value(list,ind) == obj)
        return true;
}
return false;
