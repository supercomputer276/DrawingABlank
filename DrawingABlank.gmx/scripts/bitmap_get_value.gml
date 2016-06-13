///bitmap_get_value(bitmap,index)
/*
Returns the value of indicated index of a bitmap.

argument0 - int - the bitmap value
argument1 - int - the nth bit from the far right
returns - boolean - the value of the bit
*/
return argument0 & power(2,argument1) == power(2,argument1);
