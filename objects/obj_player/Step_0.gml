//movimentação 
move=-keyboard_check(vk_left)+keyboard_check(vk_right)

hspd=move*spd

//colisão
if place_meeting(x+hspd,y,obj_solid)
{
	while !place_meeting(x+sign(hspd),y,obj_solid)
{
		x+=sign(hspd)
}
hspd=0
}


if place_meeting(x,y+vspd,obj_solid)
{
	while !place_meeting(x,y+sign(vspd),obj_solid)
{
		y+=sign(vspd)
}
vspd=0 pulo=0
}

//gravidade 
//caindo
if !place_meeting(x,y+1,obj_solid){
vspd+=grav
}
//se clicar z eu pulo
if keyboard_check_pressed(ord("Z")) && pulo==0{vspd=-8 pulo=1}

y+=vspd
x+=hspd
