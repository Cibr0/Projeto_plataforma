draw_set_font(ft_01)

//fica amarelo quando marca um ponto usando o power up
if (global.tema_ativo) {

    draw_set_alpha(0.35);
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
for (var i = 0; i < 5; i++)
{
    if (i < p.lifes)
    {
        draw_sprite(spr_heart_full, 0, 20 + (i * 40), 20);
    }
    else
    {
        draw_sprite(spr_heart_empty, 0, 20 + (i * 40), 20);
    }
}

// contador moeda
draw_sprite_ext(spr_fish, 0, 35, 80, 5, 5 ,0 ,c_white, 1);
draw_set_color(c_white);
draw_text(70, 71, string(global.moedas));

//Cooldown PowerUp
if (p != noone)
{
    if (p.alarm[1] > 0)
    {
        var tempo = ceil(p.alarm[1] / game_get_speed(gamespeed_fps));
		draw_sprite_ext(spr_echo, 0, 35, 140, 3, 3 ,0 ,c_white, 1);
		draw_text(70, 129, string(tempo));
    }
}