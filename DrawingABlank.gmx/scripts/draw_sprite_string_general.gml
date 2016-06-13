///draw_sprite_string_general(index,x,y,str,sep,w,xscale,yscale,color,alpha)
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
argument6 = real; x-scale
argument7 = real; y-scale
argument8 = color; initial color of the text
argument9 = real; initial alpha of the text
*/
var spritestringSprite = argument0,
    spritestringX = argument1,
    spritestringY = argument2,
    spritestringText = argument3,
    spritestringSep = argument4,
    spritestringWidth = argument5,
    spritestringXscale = argument6,
    spritestringYscale = argument7,
    currentColor = argument8,
    currentAlpha = argument9;
var spriteWidth = sprite_get_width(spritestringSprite),
    spriteHeight = sprite_get_height(spritestringSprite),
    baseColor = currentColor,
    baseAlpha = currentAlpha;
var lineNum = 0, cursorPos = 0; //keep track of current writing position
for(var j = 1; j <= string_length(spritestringText); j+= 1)
{
    var charToDraw = "";
    var char = string_char_at(spritestringText,j);
    //check for special characters
    if(char == "\") {
        //check for escaped charcter
        if(string_copy(spritestringText,j+1,1) == "#") {
            //draw hashtag
            charToDraw = "#";
            //increment to skip the hashtag
            j += 1;
        }
        else if(string_copy(spritestringText,j+1,2) == "c[") {
            //change color
            var colCode = string_copy(spritestringText,j+3,6);
            if(colCode == "DCOLOR") currentColor = baseColor;
            else currentColor = getHexValue(colCode);
            //increment to skip the tag
            j += 9;
        }
        //else if(string_copy(spritestringText,j+1,2) == "a[") {
            //change alpha
        //}
        else charToDraw = char;
    }
    else if(char == "#") {
        //line break
        lineNum += 1;
        cursorPos = 0;
    }
    else {
        //draw normal character at end of current line
        charToDraw = char;
    }
    //if there is a character to draw, draw it and increment the cursor
    if(charToDraw != "") {
        var ascii = ord(char);
        draw_sprite_ext(spritestringSprite,ascii,
            spritestringX+(cursorPos*(spriteWidth*spritestringXscale)),
            spritestringY+(((spriteHeight+spritestringSep)*spritestringYscale)*lineNum),
            spritestringXscale,spritestringYscale,
            0,currentColor,currentAlpha);
        cursorPos += 1;
    }
    //check for exceeding width limit
    if(spritestringWidth > 0) {
        if(char == " " || char == "-" || char == "#") { //delimiter
            var seekChar, increment = 0, deadSpace = 0;
            //deadSpace keeps track of how may characters in the string are not displayed (\ tags)
            do {
                increment++;
                seekChar = string_char_at(spritestringText,j+increment+deadSpace);
                //track dead space
                if(seekChar = "\") {
                    if(string_char_at(spritestringText,j+increment+deadSpace+1) == "#")
                        deadSpace += 1;
                    else if(string_char_at(spritestringText,j+increment+deadSpace+1) == "c")
                        deadSpace += 9;
                }
            } until(seekChar == " " || j + increment + deadSpace >= string_length(spritestringText));
            if(cursorPos+increment >= spritestringWidth) {
                lineNum += 1;
                cursorPos = 0;
            }
        }
    }
}
