///input_configure()
/*
Sets the values of the inputSetup array based on the values
in the controlSetup array and current platform.
*/
show_debug_message("-- CONFIGURING INPUT --");
//if(os_type == os_windows) { //will be necessary when there's more than one platform
    if(controlSetup[controlVariables.gamepad] == 0) { //keyboard/mouse
        show_debug_message("using keyboard and mouse");
        inputSetup[input.gamepad] = -1;
        //base actions
        if(controlSetup[controlVariables.config1] == 0) {
            inputSetup[input.move_analog] = false;
            inputSetup[input.move_left] = ord('A');
            inputSetup[input.move_right] = ord('D');
            inputSetup[input.move_up] = ord('W');
            inputSetup[input.move_down] = ord('S');
            inputSetup[input.action_primary] = vk_space;
            inputSetup[input.action_secondary] = ord('E');
            inputSetup[input.passive_primary] = vk_enter;
            inputSetup[input.passive_secondary] = vk_shift;
        }
        //drawing controls
        if(controlSetup[controlVariables.config2] == 0) {
            inputSetup[input.brush_mouse] = true;
            inputSetup[input.brush_moveh] = -1;
            inputSetup[input.brush_movev] = -1;
            inputSetup[input.brush_draw] = mb_left;
            inputSetup[input.brush_flickmouse] = true;
            inputSetup[input.brush_flickpress] = mb_right;
            inputSetup[input.brush_flickh] = -1;
            inputSetup[input.brush_flickv] = -1;
        }
    }
    else { //controller
        show_debug_message("using controller");
        inputSetup[input.gamepad] = controlSetup[controlVariables.gamepad] - 1;
        show_debug_message("num. devices: " + string(gamepad_get_device_count()));
        show_debug_message("using controller " + string(inputSetup[input.gamepad]));
        for(var i = 0; i < gamepad_get_device_count(); i++) {
            show_debug_message("controller #" + string(i) + " connected: "
                + string(gamepad_is_connected(i)));
        }
        for(var i = 1; i <= 2; i++) {
            show_debug_message("joystick #" + string(i) + " exists: "
                + string(joystick_exists(i)));
        }
        //show_debug_message("controller connected: " + string(gamepad_is_connected(inputSetup[input.gamepad])));
        gamepad_set_axis_deadzone(inputSetup[input.gamepad],0.5);
        //TODO: add controller input configurations
        //base actions
        if(controlSetup[controlVariables.config1] == 0) {
            inputSetup[input.move_analog] = false;
            inputSetup[input.move_left] = gp_padl;
            inputSetup[input.move_right] = gp_padr;
            inputSetup[input.move_up] = gp_padu;
            inputSetup[input.move_down] = gp_padd;
            inputSetup[input.action_primary] = gp_face1;
            inputSetup[input.action_secondary] = gp_face2;
            inputSetup[input.passive_primary] = gp_start;
            inputSetup[input.passive_secondary] = gp_select;
        }
        else if(controlSetup[controlVariables.config1] == 1) {
            inputSetup[input.move_analog] = true;
            inputSetup[input.move_left] = gp_axislh;
            inputSetup[input.move_right] = gp_axislh;
            inputSetup[input.move_up] = gp_axislv;
            inputSetup[input.move_down] = gp_axislv;
            inputSetup[input.action_primary] = gp_face1;
            inputSetup[input.action_secondary] = gp_face2;
            inputSetup[input.passive_primary] = gp_start;
            inputSetup[input.passive_secondary] = gp_select;
        }
        //drawing controls
        if(controlSetup[controlVariables.config2] == 0) {
            inputSetup[input.brush_mouse] = false;
            inputSetup[input.brush_moveh] = gp_axisrh;
            inputSetup[input.brush_movev] = gp_axisrv;
            inputSetup[input.brush_draw] = gp_shoulderl;
            inputSetup[input.brush_flickmouse] = true;
            inputSetup[input.brush_flickpress] = gp_shoulderlb;
            inputSetup[input.brush_flickh] = -1;
            inputSetup[input.brush_flickv] = -1;
        }
    }
//}

//initialize analog state checking based on the given values
ds_map_clear(analogState);
ds_map_clear(analogPressed);
ds_map_clear(analogReleased);
var checklist; checklist[2,2] = 0;
//flag to check     horizontal axis    vertical axis    whether to negate condition
checklist[0,0] = input.move_analog;
checklist[0,1] = input.move_left;
checklist[0,2] = input.move_up;
checklist[0,3] = false;

checklist[1,0] = input.brush_mouse;
checklist[1,1] = input.brush_moveh;
checklist[1,2] = input.brush_movev;
checklist[1,3] = true;

checklist[2,0] = input.brush_flickmouse;
checklist[2,1] = input.brush_flickh;
checklist[2,2] = input.brush_flickv;
checklist[2,3] = true;
for(var i = 0; i < array_height_2d(checklist); i++) {
    var conditional = input_get(checklist[i,0]);
    if(checklist[i,3]) conditional = !conditional;
    if(conditional) {
        analogState[? checklist[i,1]] = input_axis(checklist[i,1]);
        analogState[? checklist[i,2]] = input_axis(checklist[i,2]);
        analogPressed[? checklist[i,1]] = false;
        analogPressed[? checklist[i,2]] = false;
        analogReleased[? checklist[i,1]] = false;
        analogReleased[? checklist[i,2]] = false;
    }
}
