///initialize()
/*
Run on game start only.

Define global variables and all enumerators.
*/

/*
 INPUT
 
*/
//input control index
enum input {
    move_left,
    move_right,
    move_up,
    move_down,
    action_primary,
    action_secondary,
    passive_start,
    passive_select,
    
};

/*
 TEXTBOXES
 For managing text display
*/
display_set_gui_size(256,244);
//used for non-text characters
enum specialCharacter {
    arrow_right = 128,
    arrow_up,
    arrow_left,
    arrow_down,
    heart_full,
    heart_empty,
    brush
};
