draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, yscale, image_angle, image_blend, image_alpha);

if tuto == 1 and tuto_sprite != noone {
    draw_sprite(tuto_sprite, 0, x, y - 26);
}
if (global.dust == 1)
{
    instance_create_layer(x, y + 18, layer, obj_dust);
}