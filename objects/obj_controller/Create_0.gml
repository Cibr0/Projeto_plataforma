global.powerup2 = false;

global.moedas=0

global.crystal=0

global.wind=false

global.tema_ativo = false;

layer_set_visible("ui_menu",0)
layer_set_visible("ui_cutscene",0)
layer_set_visible("ui_cutscene2",1)

if (room == rm_01) {
    intro_sqc_element = layer_sequence_create("inst_intro", 0, 0, sqc_intro);
	intro_sqc=layer_sequence_get_instance(intro_sqc_element)
}

if !variable_global_exists("intro_finished")
{
    global.intro_finished = false;
}
