///getHexValue(string)
//return a real represented by a string of hex digits
//starts from the left
var myString = string_lower(argument0), result = 0;
//show_debug_message("getHexValue: " + myString);
for(var i = 1; i <= string_length(myString); i++) {
    //show_debug_message("increment " + string(i));
    var valString = string_char_at(myString,i);
    //show_debug_message(valString);
    var valueByte;
    switch(valString) {
        case 'f': valueByte = 15; break;
        case 'e': valueByte = 14; break;
        case 'd': valueByte = 13; break;
        case 'c': valueByte = 12; break;
        case 'b': valueByte = 11; break;
        case 'a': valueByte = 10; break;
        default: valueByte = real(valString);
    }
    //show_debug_message(string(valueByte));
    result += valueByte * power(16,i);
}
return result;
