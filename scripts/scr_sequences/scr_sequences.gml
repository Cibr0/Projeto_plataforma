// Auto-generated stubs for each available event.

function scr_mostrar_menu()
{
	layer_set_visible("ui_menu",1)
}

function scr_cutscene()
{
	global.can_move=true
	global.intro_finished = true;
}

function sqc_nextday_fadein_Moment()
{
	layer_sequence_destroy(global.seqfadein);
	global.sqc_morte = 1;
	room_restart();
	global.can_move=false
}

function sqc_nextday_fadeout_Moment()
{
	global.can_move = true;
}