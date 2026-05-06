//movimentação 
move=-keyboard_check(vk_left)+keyboard_check(vk_right)
//Botões para o pulo variavel
var key_jump_pressed = keyboard_check_pressed(ord("Z"))
var key_jump = keyboard_check(ord("Z"))
hspd=move*spd

//pulo
//se clicar z e segurar eu pulo
if key_jump_pressed && jump==0{vspd=-8 jump=1}

//gravidade 
//caindo
if !place_meeting(x,y+1,obj_solid){
vspd+=grav
}

//Pulo variavel
//limitando altura do pulo
if (!key_jump and vspd<0){vspd=max(vspd,-jump_height/2)}


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
vspd=0 jump=0
}




y+=vspd
x+=hspd
