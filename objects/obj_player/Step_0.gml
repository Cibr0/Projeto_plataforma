script_execute(estado)

if (is_invincible) {
    image_alpha = 0.4 +(sin(current_time * flash_alpha_speed) * 0.4);
} else {
    image_alpha = 1.0;
}

if place_meeting(x,y,obj_tuto){tuto=1}else{tuto=0}