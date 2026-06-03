if (y > room_height) // ou teu limite do void
{
    if (!global.dying)
    {
        global.dying = true;
        image_speed = 0;
        hspd = 0;
        vspd = 0;

        alarm[0] = 1; // morte imediata no próximo frame
    }

    exit;
}


if (global.screen_transition)
{
    image_speed = 0;
    exit;
}
else
{
    image_speed = 1;
}
script_execute(estado)

if (is_invincible) {
    image_alpha = 0.4 +(sin(current_time * flash_alpha_speed) * 0.4);
} else {
    image_alpha = 1.0;
}

//tutoriais
var tuto_obj = instance_place(x, y, obj_tuto);

if tuto_obj != noone {
    tuto = 1;
    tuto_sprite = tuto_obj.sprite_tuto;
} else {
    tuto = 0;
}

if (global.dust == 1 && !dust_created)
{
    instance_create_layer(x, y + 15, "Instances", obj_dust);
    dust_created = true;
}

if (place_meeting(x, y + 1, obj_solid))
{
    dust_created = false;
}

//Impede o jogador de voltar para telas já ultrapassadas
var _limit = obj_camera.max_screen_x;

if (x < _limit) {
    x = _limit;
}
