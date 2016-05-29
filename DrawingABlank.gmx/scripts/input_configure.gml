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
            inputSetup[input.move_left] = gp_padl;
            inputSetup[input.move_right] = gp_padr;
            inputSetup[input.move_up] = gp_padu;
            inputSetup[input.move_down] = gp_padd;
            inputSetup[input.action_primary] = gp_face1;
            inputSetup[input.action_secondary] = gp_face2;
            inputSetup[input.passive_primary] = gp_start;
            inputSetup[input.passive_secondary] = gp_select;
        }
        //drawing controls
        if(controlSetup[controlVariables.config2] == 0) {
            inputSetup[input.brush_mouse] = false;
            inputSetup[input.brush_moveh] = gp_axislh;
            inputSetup[input.brush_movev] = gp_axislv;
            inputSetup[input.brush_draw] = gp_shoulderl;
            inputSetup[input.brush_flickmouse] = true;
            inputSetup[input.brush_flickpress] = gp_shoulderlb;
            inputSetup[input.brush_flickh] = -1;
            inputSetup[input.brush_flickv] = -1;
        }
    }
//}
