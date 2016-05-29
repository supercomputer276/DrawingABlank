///input_check(enum)
/*
    Check the current value of inputControl[argument0] for if that input
    is currently inputting.
    If the input is an analogue axis, returns whether or not it's greater than 0;
    a separate function is needed for getting the axis value.
    (Not designed for use for entries of inputControl that don't hold button/key numbers)
    
    argument0 - enum - value of enum input
    returns - boolean - if the indicated input is currently down/on/pressed
*/
return input_check_general(argument0,0);
