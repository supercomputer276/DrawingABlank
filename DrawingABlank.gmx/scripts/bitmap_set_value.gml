///bitmap_set_value(bitmap,index,value)
/*
Sets a bitmap value

argument0 - int - the bitmap value
argument1 - int - the nth bit from the far right
argument2 - boolean - the value to set the bit to

returns - int - the modified bitmap value
*/
var curr = bitmap_get_value(argument0,argument1),
    ret = argument0;
if(curr) { //is 1
    if(!argument2) //set to 0
        ret -= power(2,argument1); //remove the value
}
else { //is 0
    if(argument2) //set to 1
        ret += power(2,argument1); //add the value
}
return ret;
