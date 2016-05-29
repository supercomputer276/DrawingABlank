///TMCT_Init()
/*
Initialises the globals used by the system
*/
global.TMCT_segments[0] = "";
global.TMCT_segments[1] = "";
global.TMCT_segments[2] = "";
global.TMCT_segments[3] = "";
global.TMCT_lastGestures[0] = "";
global.TMCT_lastGestures[1] = "";
global.TMCT_lastGestures[2] = "";
global.TMCT_lastGestures[3] = "";
global.TMCT_currentGestures[0] = "";
global.TMCT_currentGestures[1] = "";
global.TMCT_currentGestures[2] = "";
global.TMCT_currentGestures[3] = "";

global.TMCT_dev[0] = ds_list_create();
global.TMCT_dev[1] = ds_list_create();
global.TMCT_dev[2] = ds_list_create();
global.TMCT_dev[3] = ds_list_create();
global.TMCT_gestures = ds_map_create();
global.TMCT_lastp[0] = 0;
global.TMCT_lastp[1] = 0;
global.TMCT_lastp[2] = 0;
global.TMCT_lastp[3] = 0;

TMCT_SetNumAngleSegments(8);
TMCT_SetChangeRange(48);
TMCT_SetDetectRange(8);
