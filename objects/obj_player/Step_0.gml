script_execute(estado)

if (is_invincible) {
    image_alpha = 0.4 +(sin(current_time * flash_alpha_speed) * 0.4);
} else {
    image_alpha = 1.0;
}

var tuto_obj = instance_place(x, y, obj_tuto);

if tuto_obj != noone {
    tuto = 1;
    tuto_sprite = tuto_obj.sprite_tuto;
} else {
    tuto = 0;
}