///input_get(enum)
/*
    Retrieves the value in inputSetup cooresponding to the enum value.
    For accessing the array outside the input_* system.
    
    argument0 - enum - value of enum input
    returns - key, int, boolean - the value of inputSetup at the argument
        usually indicates a keyboard key, mouse button, controller button, or axis
        but may be other values depending on the contents of the array
*/
return inputSetup[argument0];
