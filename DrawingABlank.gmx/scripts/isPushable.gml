///isPushable(index,sign)
/*
    Checks whether or not the given instance is in a state that it can be pushed
    by the player.
    It must be on the ground and have space on the given side free.
    
    argument0 - id - the instance to check the state of
    argument1 - int/real - sign value (signCheck in the player's movement code)
    returns - boolean - whether or not the block can be pushed in the indicated direction
*/
var index = argument0,
    dir = argument1;

//show_debug_message("-- PUSHABLE CHECK --");
//check the object exists
if(!instance_exists(index)) { 
    //show_debug_message("instance doesn't exist");
    return false;
}
//check for arrow block
var objIndex = index.object_index;
//show_debug_message(object_get_name(objIndex));
if(objIndex != obj_matter_block_arrow_solid
    && objIndex != obj_void_block_arrow_solid) {
    //show_debug_message("instance isn't pushable");
    return false;
}
//check if on solid ground
with(index) {
    if(place_free(x,y+1)) {
        //show_debug_message("instance isn't on the ground");
        return false;
    }
    else {
        //show_debug_message("instance has space: " + string(place_free(x+other.dir,y)));
        return place_free(x+dir,y);
    }
}


