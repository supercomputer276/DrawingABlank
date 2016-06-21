///input_check_general(enum,mode)
/*
    Check the current value of inputControl[argument0] for different states
    of input.
    If the input is an analogue axis, can only return whether or not the axis is
    currently pressed; its value must be obtained with a different function.
    (Not designed for use for entries of inputControl that don't hold button/key numbers)
    
    argument0 - enum - value of enum input
    argument1 - int - 0 (down), 1 (pressed), or 2 (released)
    returns - boolean - if the indicated input is currently down/on/pressed
*/
var targetEnum = argument0,
    mode = argument1;
//automatically return false if the value is -1 (for no connected input)
if(inputSetup[targetEnum] == -1) return false;
//get key
var targetKey = inputSetup[targetEnum];
//determine whether input is from keyboard or a controller
if(inputSetup[input.gamepad] = -1) { //keyboard / mouse
    if(targetKey == mb_left || targetKey == mb_middle || targetKey == mb_right) {
        //mouse
        if(mode == 0) return mouse_check_button(targetKey);
        else if(mode == 1) return mouse_check_button_pressed(targetKey);
        else if(mode == 2) return mouse_check_button_released(targetKey);
    }
    else { //keyboard
        if(mode == 0) return keyboard_check(targetKey);
        else if(mode == 1) return keyboard_check_pressed(targetKey);
        else if(mode == 2) return keyboard_check_released(targetKey);
    }
}
else { //controller
    var gp = inputSetup[input.gamepad];
    if(targetKey == gp_axislh || targetKey == gp_axislv
        || targetKey == gp_axisrh || targetKey == gp_axisrv) {
        if(mode == 0) return abs(gamepad_axis_value(gp,targetKey)) != 0;
        else if(mode == 1) return analogPressed[? targetEnum];
        else if(mode == 2) return analogReleased[? targetEnum];
    }
    else {
        if(mode == 0) return gamepad_button_check(gp,targetKey);
        else if(mode == 1) return gamepad_button_check_pressed(gp,targetKey);
        else if(mode == 2) return gamepad_button_check_released(gp,targetKey);
    }
}
//in case something goes wrong
return false;
