#define initialize
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
    blotFlickTimer, blotFlickValue,
    blotRefillTimer, blotRefillValue,
    brushSpendTimer, brushSpendValue,
    brushRechargeTimer, brushRechargeValue;
currentHealth = 20; //current vitality
maxHealth = 20; //maximum vitality
currentBlots = 10; //current blots
maxBlots = 10; //maximum blots
refillBlots = 0; //blots to be steadily refilled from destroyed objects
currentBrush = 0; //current brush meter value
maxBrush = 8; //maximum brush meter value

blotFlickTimer = 0; //steps counted to track time between flicking blots continuiously
blotFlickValue = 30; //how many steps between flicking blots when the trigger is held
blotRefillTimer = 0; //steps counted to track refilling blots
blotRefillValue = 30; //how many steps to refill one blot of Void
brushSpendTimer = 0; //steps counted to spend one tick on the brush meter
brushSpendValue = 15; //how many steps before one tick on the brush meter is spent drawing
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
setupGestures();

/*
 TEXTBOXES
 For managing text display
*/
display_set_gui_size(256,224);
globalvar _gui_width, _gui_height;
_gui_width = display_get_gui_width();
_gui_height = display_get_gui_height();
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
globalvar worldGravity, targetEmptyList, targetFullList,
    recallCircleX, recallCircleY, recallCircleRadius;
worldGravity = 0.5; //gravity value
recallCircleX = 0; //used for holding the details of a recall circle
recallCircleY = 0;
recallCircleRadius = 0;

setupTargetData();
setupParticles();

#define setupGestures
///setupGestures()
/*
To be called by the initialize script only.
Starts up TMC Touch and creates appropriate gesture commands.
*/
TMCT_Init();
//circle: recall
TMCT_AddGesture("CIRCLE","45670123",true); //counterclockwise
TMCT_AddGesture("CIRCLE","07654321",true); //clockwise

//TMCT_AddGesture("CIRCLE","45670123",true);
//TMCT_AddGesture("CIRCLE","07654321",true);
TMCT_AddGesture("CIRCLE","07643210",true);
TMCT_AddGesture("CIRCLE","064210",true);
TMCT_AddGesture("CIRCLE","7654210",true);
TMCT_AddGesture("CIRCLE","765410",true);
TMCT_AddGesture("CIRCLE","0754210",true);
TMCT_AddGesture("CIRCLE","7654310",true);
TMCT_AddGesture("CIRCLE","076543210",true);
TMCT_AddGesture("CIRCLE","07654320",true);
TMCT_AddGesture("CIRCLE","07654310",true);
TMCT_AddGesture("CIRCLE","0654210",true);
TMCT_AddGesture("CIRCLE","07654210",true);
TMCT_AddGesture("CIRCLE","4560134",true);
TMCT_AddGesture("CIRCLE","4570134",true);
TMCT_AddGesture("CIRCLE","5602345",true);
TMCT_AddGesture("CIRCLE","560134",true);
TMCT_AddGesture("CIRCLE","45701234",true);
TMCT_AddGesture("CIRCLE","4570124",true);
TMCT_AddGesture("CIRCLE","4560234",true);
TMCT_AddGesture("CIRCLE","4670234",true);
TMCT_AddGesture("CIRCLE","4570234",true);
TMCT_AddGesture("CIRCLE","456701234",true);
TMCT_AddGesture("CIRCLE","457134",true);
TMCT_AddGesture("CIRCLE","45670134",true);
TMCT_AddGesture("CIRCLE","45670234",true);
TMCT_AddGesture("CIRCLE","45601234",true);
TMCT_AddGesture("CIRCLE","5670234",true);
TMCT_AddGesture("CIRCLE","075432",true);
TMCT_AddGesture("CIRCLE","1065432",true);
TMCT_AddGesture("CIRCLE","0754321",true);
TMCT_AddGesture("CIRCLE","07653210",true);
TMCT_AddGesture("CIRCLE","76520",true);
TMCT_AddGesture("CIRCLE","07643",true);
TMCT_AddGesture("CIRCLE","1065431",true);
TMCT_AddGesture("CIRCLE","06543210",true);
TMCT_AddGesture("CIRCLE","064321",true);
TMCT_AddGesture("CIRCLE","0643210",true);
TMCT_AddGesture("CIRCLE","0764210",true);
TMCT_AddGesture("CIRCLE","075431",true);
TMCT_AddGesture("CIRCLE","065432",true);
TMCT_AddGesture("CIRCLE","075321",true);
TMCT_AddGesture("CIRCLE","0653",true);
TMCT_AddGesture("CIRCLE","0754320",true);
TMCT_AddGesture("CIRCLE","076421",true);
TMCT_AddGesture("CIRCLE","06532",true);
TMCT_AddGesture("CIRCLE","4570",true);
TMCT_AddGesture("CIRCLE","456702",true);
TMCT_AddGesture("CIRCLE","467012",true);
TMCT_AddGesture("CIRCLE","45702",true);
TMCT_AddGesture("CIRCLE","46703",true);
TMCT_AddGesture("CIRCLE","47023",true);
TMCT_AddGesture("CIRCLE","467023",true);
TMCT_AddGesture("CIRCLE","457023",true);
TMCT_AddGesture("CIRCLE","467013",true);
TMCT_AddGesture("CIRCLE","467134",true);
TMCT_AddGesture("CIRCLE","456012",true);
TMCT_AddGesture("CIRCLE","4670124",true);
TMCT_AddGesture("CIRCLE","457013",true);
TMCT_AddGesture("CIRCLE","45671234",true);
TMCT_AddGesture("CIRCLE","56023",true);
TMCT_AddGesture("CIRCLE","57034",true);
TMCT_AddGesture("CIRCLE","076532",true);
TMCT_AddGesture("CIRCLE","76432",true);
TMCT_AddGesture("CIRCLE","764320",true);
TMCT_AddGesture("CIRCLE","765431",true);
TMCT_AddGesture("CIRCLE","075420",true);
TMCT_AddGesture("CIRCLE","76420",true);
TMCT_AddGesture("CIRCLE","0654320",true);
TMCT_AddGesture("CIRCLE","765310",true);
TMCT_AddGesture("CIRCLE","0764321",true);
TMCT_AddGesture("CIRCLE","065320",true);
TMCT_AddGesture("CIRCLE","0764310",true);
TMCT_AddGesture("CIRCLE","075310",true);
TMCT_AddGesture("CIRCLE","0753",true);
TMCT_AddGesture("CIRCLE","07653",true);
TMCT_AddGesture("CIRCLE","76421",true);
TMCT_AddGesture("CIRCLE","065421",true);
TMCT_AddGesture("CIRCLE","0654310",true);
TMCT_AddGesture("CIRCLE","076431",true);
TMCT_AddGesture("CIRCLE","075421",true);
TMCT_AddGesture("CIRCLE","06542",true);
TMCT_AddGesture("CIRCLE","0765432",true);
TMCT_AddGesture("CIRCLE","06543",true);
TMCT_AddGesture("CIRCLE","064310",true);
TMCT_AddGesture("CIRCLE","0621",true);
TMCT_AddGesture("CIRCLE","076432",true);
TMCT_AddGesture("CIRCLE","065431",true);
TMCT_AddGesture("CIRCLE","07543210",true);
TMCT_AddGesture("CIRCLE","76532",true);
TMCT_AddGesture("CIRCLE","764321",true);
TMCT_AddGesture("CIRCLE","0754310",true);
TMCT_AddGesture("CIRCLE","76543",true);
TMCT_AddGesture("CIRCLE","065321",true);
TMCT_AddGesture("CIRCLE","467124",true);
TMCT_AddGesture("CIRCLE","457024",true);
TMCT_AddGesture("CIRCLE","467024",true);
TMCT_AddGesture("CIRCLE","460234",true);
TMCT_AddGesture("CIRCLE","460124",true);
TMCT_AddGesture("CIRCLE","4712",true);
TMCT_AddGesture("CIRCLE","56024",true);
TMCT_AddGesture("CIRCLE","46713",true);
TMCT_AddGesture("CIRCLE","56013",true);
TMCT_AddGesture("CIRCLE","457034",true);
TMCT_AddGesture("CIRCLE","46023",true);
TMCT_AddGesture("CIRCLE","467034",true);
TMCT_AddGesture("CIRCLE","456024",true);
TMCT_AddGesture("CIRCLE","4567012",true);
TMCT_AddGesture("CIRCLE","4670134",true);
TMCT_AddGesture("CIRCLE","45602",true);
TMCT_AddGesture("CIRCLE","567023",true);
TMCT_AddGesture("CIRCLE","4670123",true);
TMCT_AddGesture("CIRCLE","46702",true);
TMCT_AddGesture("CIRCLE","567124",true);
TMCT_AddGesture("CIRCLE","5603",true);
TMCT_AddGesture("CIRCLE","456023",true);
TMCT_AddGesture("CIRCLE","46712",true);
TMCT_AddGesture("CIRCLE","670123",true);
TMCT_AddGesture("CIRCLE","57013",true);
TMCT_AddGesture("CIRCLE","5671",true);
TMCT_AddGesture("CIRCLE","5702",true);
TMCT_AddGesture("CIRCLE","56713",true);
TMCT_AddGesture("CIRCLE","5670",true);
TMCT_AddGesture("CIRCLE","5703",true);
TMCT_AddGesture("CIRCLE","07532",true);
TMCT_AddGesture("CIRCLE","654320764",true);
TMCT_AddGesture("CIRCLE","754321",true);
TMCT_AddGesture("CIRCLE","76531",true);
TMCT_AddGesture("CIRCLE","76431",true);
TMCT_AddGesture("CIRCLE","76542",true);
TMCT_AddGesture("CIRCLE","65432",true);
TMCT_AddGesture("CIRCLE","7654321",true);
TMCT_AddGesture("CIRCLE","765432",true);
TMCT_AddGesture("CIRCLE","7642",true);
TMCT_AddGesture("CIRCLE","765420",true);
TMCT_AddGesture("CIRCLE","06531",true);
TMCT_AddGesture("CIRCLE","06431",true);
TMCT_AddGesture("CIRCLE","45702345",true);
TMCT_AddGesture("CIRCLE","45701",true);
TMCT_AddGesture("CIRCLE","457012",true);
TMCT_AddGesture("CIRCLE","567123",true);
TMCT_AddGesture("CIRCLE","57023",true);
TMCT_AddGesture("CIRCLE","567134",true);
TMCT_AddGesture("CIRCLE","0765320",true);
TMCT_AddGesture("CIRCLE","75432",true);
TMCT_AddGesture("CIRCLE","75421",true);
TMCT_AddGesture("CIRCLE","05431",true);
TMCT_AddGesture("CIRCLE","560123",true);
TMCT_AddGesture("CIRCLE","45034",true);
TMCT_AddGesture("CIRCLE","56034",true);
TMCT_AddGesture("CIRCLE","5670134",true);
TMCT_AddGesture("CIRCLE","456034",true);
TMCT_AddGesture("CIRCLE","4567124",true);
TMCT_AddGesture("CIRCLE","4560124",true);
TMCT_AddGesture("CIRCLE","4560123",true);

TMCT_AddGesture("CIRCLE","32076543",true);
TMCT_AddGesture("CIRCLE","32106543",true);
TMCT_AddGesture("CIRCLE","321064",true);
TMCT_AddGesture("CIRCLE","32107643",true);
TMCT_AddGesture("CIRCLE","3217654",true);
TMCT_AddGesture("CIRCLE","320754",true);
TMCT_AddGesture("CIRCLE","310764",true);
TMCT_AddGesture("CIRCLE","3210754",true);
TMCT_AddGesture("CIRCLE","42107654",true);
TMCT_AddGesture("CIRCLE","4210654",true);
TMCT_AddGesture("CIRCLE","43210654",true);
TMCT_AddGesture("CIRCLE","3210654",true);
TMCT_AddGesture("CIRCLE","3217543",true);
TMCT_AddGesture("CIRCLE","3210643",true);
TMCT_AddGesture("CIRCLE","32107654",true);
TMCT_AddGesture("CIRCLE","3210764",true);
TMCT_AddGesture("CIRCLE","4310754",true);
TMCT_AddGesture("CIRCLE","4320764",true);
TMCT_AddGesture("CIRCLE","3217643",true);
TMCT_AddGesture("CIRCLE","4210754",true);
TMCT_AddGesture("CIRCLE","421065",true);
TMCT_AddGesture("CIRCLE","0134670",true);
TMCT_AddGesture("CIRCLE","024560",true);
TMCT_AddGesture("CIRCLE","013457",true);
TMCT_AddGesture("CIRCLE","0135670",true);
TMCT_AddGesture("CIRCLE","123467",true);
TMCT_AddGesture("CIRCLE","0234560",true);
TMCT_AddGesture("CIRCLE","124570",true);
TMCT_AddGesture("CIRCLE","1234570",true);
TMCT_AddGesture("CIRCLE","01245670",true);
TMCT_AddGesture("CIRCLE","1234670",true);
TMCT_AddGesture("CIRCLE","02347",true);
TMCT_AddGesture("CIRCLE","134670",true);
TMCT_AddGesture("CIRCLE","034570",true);
TMCT_AddGesture("CIRCLE","023471",true);
TMCT_AddGesture("CIRCLE","023460",true);
TMCT_AddGesture("CIRCLE","0124567",true);
TMCT_AddGesture("CIRCLE","065321",true);
TMCT_AddGesture("CIRCLE","065421",true);
TMCT_AddGesture("CIRCLE","76542",true);
TMCT_AddGesture("CIRCLE","0765421",true);
TMCT_AddGesture("CIRCLE","06542",true);
TMCT_AddGesture("CIRCLE","765320",true);
TMCT_AddGesture("CIRCLE","765431",true);
TMCT_AddGesture("CIRCLE","0654310",true);
TMCT_AddGesture("CIRCLE","05431",true);
TMCT_AddGesture("CIRCLE","07543",true);
TMCT_AddGesture("CIRCLE","76532",true);
TMCT_AddGesture("CIRCLE","065431",true);
TMCT_AddGesture("CIRCLE","076532",true);
TMCT_AddGesture("CIRCLE","560234",true);
TMCT_AddGesture("CIRCLE","560123",true);
TMCT_AddGesture("CIRCLE","567234",true);
TMCT_AddGesture("CIRCLE","4670234",true);
TMCT_AddGesture("CIRCLE","4570134",true);
TMCT_AddGesture("CIRCLE","467023",true);
TMCT_AddGesture("CIRCLE","560124",true);
TMCT_AddGesture("CIRCLE","567124",true);
TMCT_AddGesture("CIRCLE","45670234",true);
TMCT_AddGesture("CIRCLE","4567034",true);
TMCT_AddGesture("CIRCLE","56023",true);
TMCT_AddGesture("CIRCLE","4567023",true);
TMCT_AddGesture("CIRCLE","57034",true);
TMCT_AddGesture("CIRCLE","4570234",true);
TMCT_AddGesture("CIRCLE","5601234",true);
TMCT_AddGesture("CIRCLE","570234",true);
TMCT_AddGesture("CIRCLE","56713",true);
TMCT_AddGesture("CIRCLE","560134",true);
TMCT_AddGesture("CIRCLE","5670234",true);
TMCT_AddGesture("CIRCLE","5670134",true);
TMCT_AddGesture("CIRCLE","570134",true);
TMCT_AddGesture("CIRCLE","67023",true);
TMCT_AddGesture("CIRCLE","56712",true);
TMCT_AddGesture("CIRCLE","467013",true);
TMCT_AddGesture("CIRCLE","567123",true);
TMCT_AddGesture("CIRCLE","567023",true);
TMCT_AddGesture("CIRCLE","56012",true);
TMCT_AddGesture("CIRCLE","5702",true);
TMCT_AddGesture("CIRCLE","57023",true);
TMCT_AddGesture("CIRCLE","567034",true);
TMCT_AddGesture("CIRCLE","56024",true);
TMCT_AddGesture("CIRCLE","567134",true);
TMCT_AddGesture("CIRCLE","5713",true);
TMCT_AddGesture("CIRCLE","46713",true);
TMCT_AddGesture("CIRCLE","123467",true);
TMCT_AddGesture("CIRCLE","023567",true);
TMCT_AddGesture("CIRCLE","432075",true);
TMCT_AddGesture("CIRCLE","320764",true);
TMCT_AddGesture("CIRCLE","1234567",true);
TMCT_AddGesture("CIRCLE","320765",true);
TMCT_AddGesture("CIRCLE","0234567",true);
TMCT_AddGesture("CIRCLE","1234670",true);
TMCT_AddGesture("CIRCLE","32064",true);
TMCT_AddGesture("CIRCLE","123567",true);
TMCT_AddGesture("CIRCLE","3107654",true);
TMCT_AddGesture("CIRCLE","0124567",true);
TMCT_AddGesture("CIRCLE","012467",true);
TMCT_AddGesture("CIRCLE","32107654",true);
TMCT_AddGesture("CIRCLE","01234670",true);
TMCT_AddGesture("CIRCLE","124670",true);
TMCT_AddGesture("CIRCLE","32065",true);
TMCT_AddGesture("CIRCLE","134560",true);
TMCT_AddGesture("CIRCLE","432065",true);
TMCT_AddGesture("CIRCLE","01235670",true);
TMCT_AddGesture("CIRCLE","3210765",true);
TMCT_AddGesture("CIRCLE","0124670",true);
TMCT_AddGesture("CIRCLE","310764",true);
TMCT_AddGesture("CIRCLE","0123467",true);
TMCT_AddGesture("CIRCLE","3207654",true);
TMCT_AddGesture("CIRCLE","0134570",true);
TMCT_AddGesture("CIRCLE","432107654",true);
TMCT_AddGesture("CIRCLE","01234567",true);
TMCT_AddGesture("CIRCLE","321065",true);
TMCT_AddGesture("CIRCLE","013467",true);
TMCT_AddGesture("CIRCLE","310765",true);
TMCT_AddGesture("CIRCLE","0134567",true);
TMCT_AddGesture("CIRCLE","3210654",true);
TMCT_AddGesture("CIRCLE","310654",true);
TMCT_AddGesture("CIRCLE","134570",true);
TMCT_AddGesture("CIRCLE","45701234",true);
TMCT_AddGesture("CIRCLE","0765421",true);
TMCT_AddGesture("CIRCLE","765431",true);
TMCT_AddGesture("CIRCLE","5670134",true);
TMCT_AddGesture("CIRCLE","065431",true);
TMCT_AddGesture("CIRCLE","46701234",true);
TMCT_AddGesture("CIRCLE","567023",true);
TMCT_AddGesture("CIRCLE","064310",true);
TMCT_AddGesture("CIRCLE","57034",true);
TMCT_AddGesture("CIRCLE","765310",true);
TMCT_AddGesture("CIRCLE","467024",true);
TMCT_AddGesture("CIRCLE","7654320",true);
TMCT_AddGesture("CIRCLE","7654310",true);
TMCT_AddGesture("CIRCLE","45702",true);
TMCT_AddGesture("CIRCLE","4560234",true);
TMCT_AddGesture("CIRCLE","45670134",true);
TMCT_AddGesture("CIRCLE","46701234",true);
TMCT_AddGesture("CIRCLE","45601234",true);
TMCT_AddGesture("CIRCLE","456701234",true);
TMCT_AddGesture("CIRCLE","45670",true);
TMCT_AddGesture("CIRCLE","45701",true);
TMCT_AddGesture("CIRCLE","57013",true);
TMCT_AddGesture("CIRCLE","5601234",true);
TMCT_AddGesture("CIRCLE","56713",true);
TMCT_AddGesture("CIRCLE","5602",true);
TMCT_AddGesture("CIRCLE","570134",true);
TMCT_AddGesture("CIRCLE","76542",true);
TMCT_AddGesture("CIRCLE","6542",true);
TMCT_AddGesture("CIRCLE","7654321",true);
TMCT_AddGesture("CIRCLE","5601",true);
TMCT_AddGesture("CIRCLE","5702",true);
TMCT_AddGesture("CIRCLE","57023",true);
TMCT_AddGesture("CIRCLE","570124",true);
TMCT_AddGesture("CIRCLE","076542",true);
TMCT_AddGesture("CIRCLE","765431",true);
TMCT_AddGesture("CIRCLE","754210",true);
TMCT_AddGesture("CIRCLE","076421",true);
TMCT_AddGesture("CIRCLE","7643",true);
TMCT_AddGesture("CIRCLE","7653210",true);
TMCT_AddGesture("CIRCLE","65421",true);
TMCT_AddGesture("CIRCLE","0764320",true);
TMCT_AddGesture("CIRCLE","560134",true);
TMCT_AddGesture("CIRCLE","567024",true);
TMCT_AddGesture("CIRCLE","024670",true);
TMCT_AddGesture("CIRCLE","134671",true);
TMCT_AddGesture("CIRCLE","0234670",true);
TMCT_AddGesture("CIRCLE","012467",true);
TMCT_AddGesture("CIRCLE","12467",true);
TMCT_AddGesture("CIRCLE","023467",true);
TMCT_AddGesture("CIRCLE","12457",true);
TMCT_AddGesture("CIRCLE","57024",true);
TMCT_AddGesture("CIRCLE","567124",true);
TMCT_AddGesture("CIRCLE","4670134",true);
TMCT_AddGesture("CIRCLE","4570134",true);
TMCT_AddGesture("CIRCLE","4570234",true);
TMCT_AddGesture("CIRCLE","4570124",true);
TMCT_AddGesture("CIRCLE","56034",true);
TMCT_AddGesture("CIRCLE","4560134",true);
TMCT_AddGesture("CIRCLE","0654310",true);
TMCT_AddGesture("CIRCLE","0654210",true);
TMCT_AddGesture("CIRCLE","07543210",true);
TMCT_AddGesture("CIRCLE","07654210",true);
TMCT_AddGesture("CIRCLE","0765310",true);
TMCT_AddGesture("CIRCLE","765320",true);
TMCT_AddGesture("CIRCLE","76521",true);
TMCT_AddGesture("CIRCLE","7654310",true);
TMCT_AddGesture("CIRCLE","065210",true);
TMCT_AddGesture("CIRCLE","0654321",true);
TMCT_AddGesture("CIRCLE","560234",true);
TMCT_AddGesture("CIRCLE","7654210",true);
TMCT_AddGesture("CIRCLE","460134",true);
#define setupTargetData
///setupTargetData()
/*
    Run with initialize() only.
    Sets up the data structures that keep track of what objects are targetable
    (are affected by painting Void on them) and what objects are filled with Void
    (are affected by MATTER IMPs, recalling, etc.). Objects that can be voided
    can have multiple different kinds of required behavior, the simple parent-child
    system GameMaker provides can't do it.
    
    The data structures are lists, with the even indices (0, 2, 4...) holding
    the object index and the odd incides (1, 3, 5...) holding the amount of Void
    blots tied to the object (either to fill it or to come out of it) in the index
    directly before it. If the odd index holds -1, then the void tied to it
    is defined per instance via its voidAmount variable.
*/
//list of all objects that can be filled with Void
// (as some objects must be children of different objects than others)
targetEmptyList = ds_list_create();
ds_list_add(targetEmptyList,obj_matter_block_basic_solid, 1);
ds_list_add(targetEmptyList,obj_matter_block_bit_solid, 1);
ds_list_add(targetEmptyList,obj_void_block_basic_phased, 1);
ds_list_add(targetEmptyList,obj_matter_block_large_solid, -1);
ds_list_add(targetEmptyList,obj_void_block_large_phased, -1);

//list of all objects that are filled with Void
// (for the same reasons as bove)
targetFullList = ds_list_create();
ds_list_add(targetFullList,obj_matter_block_basic_phased, 1);
ds_list_add(targetFullList,obj_matter_block_bit_phased, 1);
ds_list_add(targetFullList,obj_void_block_basic_solid, 1);
ds_list_add(targetFullList,obj_matter_block_large_phased, -1);
ds_list_add(targetFullList,obj_void_block_large_solid, -1);

#define setupParticles
///setupParticles()
/*
    Initalizes particle system representing Void and Matter activity.
*/
globalvar particleSystem,
    checkpointParticle, deathParticle,
    checkpointEmitter, deathEmitter;

//particle system
particleSystem = part_system_create();
part_system_depth(particleSystem,9);

//checkpoint particle type
checkpointParticle = part_type_create();
part_type_shape(checkpointParticle,pt_shape_disk);
part_type_size(checkpointParticle,0.1,0.3,0,0);
part_type_color1(checkpointParticle,c_black);
part_type_alpha2(checkpointParticle,0.9,0);
part_type_life(checkpointParticle,3,8);
part_type_speed(checkpointParticle,2,5,0,0);
part_type_direction(checkpointParticle,0,360,0,0);

//death particle type - a little more solid
deathParticle = part_type_create();
part_type_shape(deathParticle,pt_shape_disk);
part_type_size(deathParticle,0.2,0.5,0,0);
part_type_color1(deathParticle,c_black);
part_type_alpha2(deathParticle,0.8,0.8);
part_type_life(deathParticle,4,10);
part_type_speed(deathParticle,2,5,0,0);
part_type_direction(deathParticle,0,360,0,0);

//there's only one emitter, it just moves
checkpointEmitter = part_emitter_create(particleSystem);
deathEmitter = part_emitter_create(particleSystem);