///getTargetableVoid(instance,fulltargets)
/*
    Returns the amount of Void that can be tied to the instance.
    Returns 0 if the object is not on the list.
    
    argument0 - id - instance to determine the targetability of
    argument1 - boolean - check empty (false) or full (true) targetable list
    returns - boolean - if the instance is targetable
*/
if(!checkTargetable(argument0,argument1)) return 0;

var obj = argument0.object_index;
var list;
if(argument1) list = targetFullList;
else list = targetEmptyList;
for(var ind = 0; ind < ds_list_size(list); ind += 2) {
    if(ds_list_find_value(list,ind) == obj)
        return ds_list_find_value(list,ind+1);
}
return 0;
