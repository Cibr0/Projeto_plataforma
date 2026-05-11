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

if (falling) {vspd += grav y+=vspd	 }

