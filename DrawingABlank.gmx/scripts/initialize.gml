///initialize()
/*
Run on game start only.

Define global variables and all enumerators.
*/

/*
 PLAYER
 Current state of the VOID IMP.
*/
globalvar currentHealth, maxHealth,
    currentBlots, maxBlots, refillBlots,
    currentBrush, maxBrush,
    blotRefillTimer, blotRefillValue, brushRechargeTimer, brushRechargeValue;
currentHealth = 20; //current vitality
maxHealth = 20; //maximum vitality
currentBlots = 10; //current blots
maxBlots = 100; //maximum blots
refillBlots = 100; //blots to be steadily refilled from destroyed objects
currentBrush = 0; //current brush meter value
maxBrush = 16; //maximum brush meter value

blotRefillTimer = 0; //steps counted to track refilling blots
blotRefillValue = 30; //how many steps to refill one blot of Void
brushRechargeTimer = 0; //steps counted to track recharging the brush
brushRechargeValue = 60; //how many steps to recharge one tick on the brush meter

/*
 INPUT
 for handling player input configurations
*/
//input control index
globalvar inputSetup, controlSetup;
enum input { //constants for inputSetup indices
    move_left, //left on a D-pad
    move_right, //right on a D-pad
    move_up, //up on a D-pad
    move_down, //down on a D-pad
    action_primary, //A button
    action_secondary, //B button
    passive_primary, //Start button
    passive_secondary, //Select button
    brush_mouse, //flag to determine whether or not to use brush cursor movements (0 for use analog stick, 1 to use first device pointer)
    brush_moveh, //horizontal analog for brush cursor movement (NE if brush_mouse is 1)
    brush_movev,  //vertial analog for brush cursor movement (NE if brush_mouse is 1)
    brush_draw, //trigger to hold down to draw
    brush_flickmouse, //flag to determine whether or not to use analog flick input (0 for use analog stick, 1 to use cursor position and trigger)
    brush_flickpress, //trigger to press/hold to flick (NE if brush_flickmouse is 0)
    brush_flickh, //horizontal analog for flicking (NE if brush_flickmouse is 1)
    brush_flickv, //vertical analog for flicking (NE if brush_flickmouse is 1)
    gamepad, //which gamepad to use (-1 is keyboard, 0-3 for gamepad in that slot)
};
inputSetup[input.gamepad] = -1; //holds which buttons/keys are used during gameplay
enum controlVariables {
    gamepad, //which gamepad to use; ranges 0-4 (keyboard/mouse if 0; else gamepad in slot <this value>-1)
    config1, //configuration part 1: basic (NES) controls
    config2, //configuration part 2: brush controls
};
controlSetup[controlVariables.gamepad] = 0; //these are set, then used as inputs to generate the desired control scheme
controlSetup[controlVariables.config1] = 0;
controlSetup[controlVariables.config2] = 0;
//if an options file exists, load configuration from there
//set controls
input_configure();
//gesture setup


/*
 TEXTBOXES
 For managing text display
*/
display_set_gui_size(256,224);
//used for non-text characters
enum specialCharacter {
    arrow_right = 128,
    arrow_up,
    arrow_left,
    arrow_down,
    heart_full,
    heart_empty,
    brush,
    meter_0,
    meter_1,
    meter_2,
    meter_3,
    meter_4,
    meter_5,
    meter_6,
    meter_7,
    meter_8,
};

/*
 ENVIRONMENT
 Misc. variables
*/
globalvar worldGravity;
worldGravity = 0.5; //gravity value
