///TMCT_Destroy()
/*
Frees the globals used by the system
*/
ds_list_destroy(global.TMCT_dev[0]);
ds_list_destroy(global.TMCT_dev[1]);
ds_list_destroy(global.TMCT_dev[2]);
ds_list_destroy(global.TMCT_dev[3]);
ds_map_destroy(global.TMCT_gestures);
