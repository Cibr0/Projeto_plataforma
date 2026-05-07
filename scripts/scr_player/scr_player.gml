
function scr_player(){

#region Movimentação e colisão horizontal

move=-keyboard_check(vk_left)+keyboard_check(vk_right)
hspd=move*spd

//Colisão horizontal
if place_meeting(x+hspd,y,obj_solid)
{
	while !place_meeting(x+sign(hspd),y,obj_solid)
{
		x+=sign(hspd)
}
hspd=0
}

x+=hspd
#endregion

#region Pulo variavel, CoyoteTime, Jump Buffer e Gravidade

//Botões para o pulo variavel
var key_jump_pressed = keyboard_check_pressed(ord("Z"))
var key_jump = keyboard_check(ord("Z"))

//Jump Buffer
if (key_jump_pressed){
	jump_buffer = jump_buffer_max
}else if (jump_buffer > 0){
	jump_buffer--
}

//Coyote Time
//Enquanto o player estiver no chão, o contador é restaurado
//Ao sair da plataforma, ele começa a diminuir
if place_meeting(x, y + 1, obj_solid){
	coyote_time = coyote_time_max
}else{
	coyote_time--
}

//Pulo
//O pulo acontece quando existe input armazenado
//e o jogador ainda pode pular pelo chão ou coyote time
if (jump_buffer > 0 and (place_meeting(x, y + 1, obj_solid) or coyote_time > 0))
{
	jump_buffer = 0
	coyote_time = 0
	vspd = -jump_height
}

//Pulo variavel
//limitando altura do pulo
if (!key_jump and vspd < 0){vspd = max(vspd, -jump_height / 2)}

//gravidade
if !place_meeting(x, y + 1, obj_solid){vspd += grav}

#endregion

#region Colisão vertival 

if place_meeting(x,y+vspd,obj_solid)
{
	while !place_meeting(x,y+sign(vspd),obj_solid)
{
		y+=sign(vspd)
}
vspd=0 
}

y+=vspd

#endregion

}