global.check_x = 0;
global.check_y = 0;

function scr_player_onground(){

#region Movimentação e colisão horizontal

if global.can_move{
//Variavel de movimentação
move = -keyboard_check(vk_left) + keyboard_check(vk_right);
}else{
move=0
}
//Variaveis de colisão
var ground = place_meeting(x, y + 1, obj_solid);
var ice = place_meeting(x, y + 1, obj_ice);


//aceleração
if (!hurt)
{
    //aceleração
    if (move != 0) {
        hspd += move * acc;
        hspd = clamp(hspd, -spd_max, spd_max);
    }

    //desaceleração/fricção
else {

    var wind = instance_place(x, y, obj_wind);

    var cancel_friction = false;

    if (wind) {

        // vento pra esquerda
        if (wind.force > 0 && hspd < 0) {
            cancel_friction = true;
        }

        // vento pra direita
        if (wind.force < 0 && hspd > 0) {
            cancel_friction = true;
        }

    }

    if (!cancel_friction) {

        if (hspd > 0) {
            hspd = max(0, hspd - dcc);
        }
        else if (hspd < 0) {
            hspd = min(0, hspd + dcc);
        }

    }

}}

//knockback
else

{
    hspd *= 0.90;

    if (abs(hspd) < 0.5)
    {
        hurt = false;
        hspd = 0;
    }
}


//mudança de valores de aceleração e desaceleração
if (ground) {
    acc = 0.28;
    dcc = 0.28;
	double_jump_anim = false;

if (variable_global_exists("powerup2")) {
    
    if (global.powerup2 && !hurt) {
        double_jump = true;
    }
}

    if (ice) {
        acc = 0.12;
        dcc = 0.001;
    }
}
else {
    acc = 0.20;
    dcc = 0;
}
#endregion

#region Vento Lateral

var wind = instance_place(x, y, obj_wind);

if (wind) {
    hspd += -wind.force;
}

#endregion

#region Colisão horizontal
if place_meeting(x+round(hspd),y,obj_solid)
{
	while !place_meeting(x+sign(hspd),y,obj_solid)
{
		x+=sign(hspd)
}
hspd=0
}

x += round(hspd);
#endregion

#region Pulo variavel, CoyoteTime, Jump Buffer e Gravidade
if global.can_move{
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
if ground{
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

if (keyboard_check_pressed(ord("Z")) and !place_meeting(x, y + 1, obj_solid) and coyote_time <0 and !hurt) {
   if (variable_global_exists("powerup2") and global.powerup2 and double_jump) {
        vspd = -jump_height;     
        double_jump = false; 
        jump_buffer = 0; 
		
		// ativa animação do segundo pulo
        double_jump_anim = true;
    }
}

//Pulo variavel
//limitando altura do pulo
if (!key_jump and vspd < 0){vspd = max(vspd, -jump_height / 2)}

//gravidade
if (!ground) vspd += grav;
}
#endregion

#region Colisão vertival


if place_meeting(x,y+(vspd),obj_solid)
{
	while !place_meeting(x,y+sign(vspd),obj_solid)
{
		y+=sign(vspd)
}
vspd=0
}

y+= vspd;

#endregion

#region Eco Temporal (Power-up)

//so funciona se o jogador desbloquear o power up
if global.powerup1=true{
// Input do Eco 
var key_eco = keyboard_check_pressed(ord("X"));


	// Se mudou de tela, cancela o Eco Temporal
if (global.screen_transition && eco_load) {

    eco_load = false;
    eco = false;

    // desativa tema alternativo
    global.tema_ativo = false;

    // cancela o alarme do eco ativo
    alarm[0] = -1;

    // inicia cooldown
    if (alarm[1] <= 0) {
        alarm[1] = eco_cooldown;
    }
}
if (key_eco) {
    // ESTADO 1: Criar o Eco
    // Só funciona se o poder estiver carregado (eco) e não houver um ponto ativo (!eco_load)
    if (eco && !eco_load) {
		
        ecox = x;
        ecoy = y;
		
        eco_load = true; 
		//atima tema alternativo
		global.tema_ativo = true;
		
		// Inicia o alarme de expiração (O ponto dura 10 segundos)
        alarm[0] = eco_time; 
        
    }
    // ESTADO 2: Retornar ao Eco
    // Só funciona se já existir um ponto salvo (eco_load)
    else if (eco_load) {
        x = ecox;
        y = ecoy;
		
		//desativa o tema
		global.tema_ativo = false;
		
        
        // Zera a velocidade para não chegar no destino caindo ou subindo
        vspd = 0; 
        hspd = 0;
        
        // Reset de estados
        eco_load = false;
        eco = false;
        
        // Cancela o alarme de expiração 
        alarm[0] = -1; 
        
        // Inicia o alarme de recarga (Cooldown de 5 segundos)
        if (alarm[1] <= 0) alarm[1] = eco_cooldown;
       
		}
	}
}
#endregion

#region Água

var water = place_meeting(x, y, obj_water);


if (water){

//Gravidade reduzida
grav = 0.08;

//Movimento mais lento
acc = 0.10;
dcc = 0.08;
spd_max = 1;
	
//Limite de queda
vspd = clamp(vspd, -2, 2);

//Empuxo (faz o player afundar lentamente)
if (vspd > 1.5) {
    vspd = 1.5;
}

//Nadar pra cima
if (keyboard_check_pressed(ord("Z"))) {
    vspd -= 5;
	}
}else {
//Valores normais
grav=0.2;
spd_max = 2;
}
#endregion

#region animations

//Define os sprites baseado no powerup
var spr_idle = global.powerup1 ? spr_cat_idle_bandana : spr_cat_idle;
var spr_walk = global.powerup1 ? spr_cat_walk_bandana : spr_cat_walk;
var spr_jump = global.powerup1 ? spr_cat_jump_bandana : spr_cat_jump;
var spr_double_jump = spr_cat_jordan;
var spr_fall = global.powerup1 ? spr_cat_fall_bandana : spr_cat_fall;

//direção
switch(sign(move)){

    case 1:
        image_xscale = -1;
    break;

    case -1:
        image_xscale = 1;
    break;

}

//Animação na água
if (water){

    switch sign(move){

        case 1:
            image_xscale = -1;
            sprite_index = spr_walk;
        break;

        case -1:
            image_xscale = 1;
            sprite_index = spr_walk;
        break;

        case 0:
            sprite_index = spr_idle;
        break;
    }

}else if (!ground) {

    // segundo pulo subindo
    if (double_jump_anim && vspd < 0){

        sprite_index = spr_double_jump;
		global.dust=1

    }

    // caindo depois do double jump
    else if (double_jump_anim && vspd > 0){

        sprite_index = spr_fall;
		global.dust=0
    }

    // pulo normal
    else{

        sprite_index = spr_jump;

    }

}else{

    // animações no chão
    switch sign(move){

        case 1:
            image_xscale = -1;
            sprite_index = spr_walk;
        break;

        case -1:
            image_xscale = 1;
            sprite_index = spr_walk;
        break;

        case 0:
            sprite_index = spr_idle;
        break;
    }

}

#endregion

#region squash e stretch
var target_y = yscale_standard;

// subindo
if (!ground && vspd < 0)
{
    target_y = 1.3;
}

// caindo
else if (!ground && vspd > 0)
{
    target_y = 0.85;
}

// volta normal
else
{
    target_y = yscale_standard;
}

// suaviza
yscale = lerp(yscale, target_y, 0.2);
#endregion



}


