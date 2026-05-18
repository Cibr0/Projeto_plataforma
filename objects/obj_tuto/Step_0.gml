if required_powerup {

    if global.powerup1=true {

        if global.tema_ativo=true {
			sprite_tuto=spr_return
            sprite_tuto_active = sprite_tuto;
        } else {
			sprite_tuto=spr_x
            sprite_tuto_active = sprite_tuto;
        }

    } else {
        sprite_tuto_active = noone;
    }

} else {

    if keyboard_check_pressed(ord("X")) {
        sprite_tuto_active = sprite_tuto;
    } else {
        sprite_tuto_active = sprite_tuto;
    }

}