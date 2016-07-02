///voidRecall([x1,y1,x2,y2])
/*
    Run void recall sequence.
    Used when a Recall glyph is used or the player dies.
    
    if 0 arguments - Full Recall
    if 4 arguments - Partial Recall
        argument0 - int - x-coordinate of top-left corner of recall area
        argument1 - int - y-coordinate of top-left corner of recall area
        argument2 - int - x-coordinate of bottom-right corner of recall area
        argument3 - int - y-coordinate of bottom-right corner of recall area
*/
//show_debug_message("-- RECALLING --");
//fully voided objects
for(var i = 0; i < ds_list_size(targetFullList) / 2; i++) {
    var target = getTargetableObject(i,1);
    //show_debug_message(object_get_name(target));
    for(var j = 0; j < instance_number(target); j++) {
        var inst = instance_find(target,j);
        var potential = getTargetableVoid(inst,1);
        if(potential == -1) potential = inst.voidAmount;
        //show_debug_message(string(potential));
        refillBlots += potential;
        effect_create_above(ef_ring,inst.x+inst.sprite_width/2,
            inst.y+inst.sprite_height/2,0,c_black);
        with(inst) event_user(0);
    }
}//partially voided objects
for(var i = 0; i < ds_list_size(targetEmptyList) / 2; i++) {
    var target = getTargetableObject(i,0);
    //show_debug_message(object_get_name(target));
    for(var j = 0; j < instance_number(target); j++) {
        var inst = instance_find(target,j);
        stuffdoneFlag = false;
        with(inst) event_user(1);
        if(stuffdoneFlag)
            effect_create_above(ef_ring,inst.x+inst.sprite_width/2,
                inst.y+inst.sprite_height/2,0,c_black);
    }
}
