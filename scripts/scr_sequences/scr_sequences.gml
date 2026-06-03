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

function sqc_nextday_fadeout2_Moment()
{
	global.can_move = true;
}

function sqc_nextrm_fadein_Moment()
{
	global.can_move=false
	layer_sequence_destroy(global.seqfadeinrm);
	global.sqcfinal = layer_sequence_create("UI",0,0,sqc_final)	
	
}

function sqc_final()
{
	
	global.sqcfinal2 = layer_sequence_create("UI2",0,0,sqc_menu_2)
}

function sqc_finalin(){
	display_set_gui_size(1280,720)
	layer_sequence_destroy(global.sqcfinal);
}
function sqc_end(){
	game_end()
}