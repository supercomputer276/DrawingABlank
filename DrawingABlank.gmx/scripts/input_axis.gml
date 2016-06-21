///input_axis(enum)
/*
    Returns the amount of tilt on the analogue axis tied to the given enum value
    in the inputSetup array.
    Returns 0 if the tied key is not an axis.
    
    argument0 - enum - a value in enum input
    returns - real - -1 to 1; current value of that axis
*/
var targetEnum = argument0;
//automatically return false if the value is -1 (for no connected input)
if(inputSetup[input.gamepad] == -1) return false;
//get key
var targetKey = inputSetup[targetEnum];
//check if axis
if(targetKey == gp_axislh || targetKey == gp_axislv
    || targetKey == gp_axisrh || targetKey == gp_axisrv) {
    return gamepad_axis_value(inputSetup[input.gamepad],targetKey);
}
else return 0;
