///draw_sprite_string_transformed_color(index,x,y,str,xscale,yscale,color,alpha)
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
argument4 = real; x-scale
argument5 = real; y-scale
argument6 = color; initial color of the text
argument7 = real; initial alpha of the text
*/
draw_sprite_string_general(argument0,argument1,argument2,argument3,
    0,0,argument4,argument5,argument6,argument7);
