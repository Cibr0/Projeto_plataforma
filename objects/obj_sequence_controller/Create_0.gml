
if (!variable_global_exists("sqc_morte"))
{
    global.sqc_morte = -1;
}

if (global.sqc_morte == 1)
{
	display_set_gui_size(320,180);
    layer_sequence_create("UI", 0, 0, sqc_nextday_fadeout);
    global.sqc_morte = -1;
	
}
