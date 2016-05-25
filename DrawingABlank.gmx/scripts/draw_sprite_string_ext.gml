///draw_sprite_string_ext(index,x,y,str,sep,w)
/*
draws text composed of sprite characters
multi-line functionality

special features:
\c[XXXXXX] in a string will change the color to $XXXXXX
    if XXXXXX is "DCOLOR", will reset to the initial color
\a[REAL] in a string will change the alpha to REAL

argument0 = index; sprite to draw with
argument1 = real; x of top-left
argument2 = real; y of top-left
argument3 = string; what to write
argument4 = int; number of pixels between lines
argument5 = int; maximum number of characters to display on each line (infinite if <= 0)
*/
draw_sprite_string_general(argument0,argument1,argument2,argument3,
    argument4,argument5,1,1,draw_get_color(),1);
