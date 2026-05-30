if (!stepping){
if place_meeting(x, y-1, obj_player){
	stepping=true;
	}
}

if (stepping and !falling){
	fall_time--;
}

if fall_time<=0{
falling=true

}
if (falling) {vspd += grav y+=vspd restore_time--; }

if (restore_time <= 0) {
    x = x_start;
    y = y_start;

    vspd = 0;
    stepping = false;
    falling = false;

    fall_time = 20;
    restore_time = 90;
}




