
function scr_player_onground(){

#region Movimentação e colisão horizontal

//Variavel de movimentação
move = -keyboard_check(vk_left) + keyboard_check(vk_right);
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
        if (hspd > 0) {
            hspd = max(0, hspd - dcc);
        }
        else if (hspd < 0) {
            hspd = min(0, hspd + dcc);
        }
    }
}
else
{
    hspd *= 0.90;

    if (abs(hspd) < 0.5)
    {
        hurt = false;
        hspd = 0;
    }
}

if (ground) {
    acc = 0.28;
    dcc = 0.35;

    if (ice) {
        acc = 0.12;
        dcc = 0.05;
    }
}
else {
    acc = 0.20;
    dcc = 0;
}

#region Vento Lateral

var wind = instance_place(x, y, obj_wind);
var wind_force = 0;

if (wind) {
    wind_force = -wind.force;
}

hspd += wind_force;

#endregion

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

#region Eco Temporal (Power-up)

// Input do Eco 
var key_eco = keyboard_check_pressed(ord("X"));

if (key_eco) {
    // ESTADO 1: Criar o Eco
    // Só funciona se o poder estiver carregado (eco) e não houver um ponto ativo (!eco_load)
    if (eco && !eco_load) {
        ecox = x;
        ecoy = y;
        eco_load = true; 
		
		// Inicia o alarme de expiração (O ponto dura 10 segundos)
        alarm[0] = eco_time; 
        
    } 
    // ESTADO 2: Retornar ao Eco
    // Só funciona se já existir um ponto salvo (eco_load)
    else if (eco_load) {
        x = ecox;
        y = ecoy;
        
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

#endregion

#region Água

var water = place_meeting(x, y, obj_water);

if (water){

//Gravidade reduzida
grav = 0.08;

//Movimento mais lento
acc = 0.10;
dcc = 0.08;
spd_max = 2;
	
//Limite de queda
vspd = clamp(vspd, -2, 2);

//Empuxo (faz o player afundar lentamente)
if (vspd > 1.5) {
    vspd = 1.5;
}

//Nadar pra cima
if (keyboard_check_pressed(ord("Z"))) {
    vspd -= 10;
	}
}else {
//Valores normais
grav=0.3;
spd_max = 3;
}
#endregion


#region animations
//Animação de pulo
if (!ground) {

    sprite_index = spr_cat_jump;

}
//Animações no chão
else {

    switch sign(move){

        case 1:
            image_xscale = -1;
            sprite_index = spr_cat_walk;
        break;

        case -1:
            image_xscale = 1;
            sprite_index = spr_cat_walk;
        break;

        case 0:
            sprite_index = spr_cat_idle;
        break;
    }

}

#endregion

#region Knockback
if (hurt)
{
    hsp *= 0.90;

    if (abs(hsp) < 0.5)
    {
        hurt = false;
        hsp = 0;
    }
}

}


