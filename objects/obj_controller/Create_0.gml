global.moedas=0

global.wind=false

// CREATE do obj_controller

global.tema_ativo = false;

layer_set_visible("ui_menu",0)
layer_set_visible("ui_cutscene",0)
layer_set_visible("ui_cutscene2",1)

if (room == rm_01) {
    layer_sequence_create("inst_intro", x, y, sqc_intro);
}