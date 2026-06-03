display_set_gui_size(320,180);
if global.can_move{

draw_set_font(ft_01)

//fica amarelo quando marca um ponto usando o power up
if (global.tema_ativo) {

    draw_set_alpha(0.20);
    draw_set_color(c_yellow);

    draw_rectangle(
        0,
        0,
        display_get_gui_width(),
        display_get_gui_height(),
        false
    );

    draw_set_alpha(1);
    draw_set_color(c_white);
}


var p = instance_find(obj_player, 0);

//HUD
// desenhar corações
for (var i = 0; i < 3; i++)
{
    if (i < p.lifes)
    {
        draw_sprite_ext(spr_heart_full, 0, 3 + (i * 8), 5,1,1,0,c_white,1);
    }
    else
    {
        draw_sprite_ext(spr_heart_empty, 0, 3 + (i * 8), 5,1,1,0,c_white,1);
    }
}

// contador moeda
draw_sprite_ext(spr_fish, 0, 11, 25, 1, 1 ,0 ,c_white, 1);
draw_set_color(c_white);
draw_text_transformed(20,22.5,string(global.moedas),0.3,0.3,0);


//Cooldown PowerUp
if (p != noone)
{
    if (p.alarm[1] > 0)
    {
        var tempo = ceil(p.alarm[1] / game_get_speed(gamespeed_fps));
		draw_sprite_ext(spr_echo, 0, 11, 35, 0.7, 0.7 ,0 ,c_white, 1);
		draw_text_transformed(20, 32.5, string(tempo),0.3,0.3,0);
    }
}
}