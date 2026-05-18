estado=scr_player_onground

//movimentação
hspd=0;
vspd=0;
spd=0;
spd_max=2;
acc=0.28;
dcc=0.28;

//gravidade e pulo
grav=0.2;
jump_height=4;
jump_buffer = 0;
jump_buffer_max = 8;
coyote_time_max=11;
coyote_time=0;

// Power-up: Eco Temporal
eco = true;
eco_load = false;
ecox = 0;
ecoy = 0;

// Tempo de ativação e de Recarga
eco_time = game_get_speed(gamespeed_fps) * 10; 
eco_cooldown = game_get_speed(gamespeed_fps) * 5;

lifes = 5; // Número de vida do jogador
is_invincible = false; // Impede novos danos se true
iframe_duration = game_get_speed(gamespeed_fps) * 1; // Tempod de invulnerabilidade (1 segundo)

flash_alpha_speed = 0.15; // Velocidade da oscilção do efeito

function damage (_damage_amount) {
    if (is_invincible) exit;

    lifes -= _damage_amount; // Aplica o dano 

    // Ativa a flag de proteção
    is_invincible = true; 
    alarm[2] = iframe_duration;

	if (lifes <= 0) {
		//iniciando na posição do checkpoint
		if (global.check_y != 0) {
			x = global.check_x;
			y = global.check_y;
			room_restart()
		} else {
			room_restart(); // Reinicia a fase atual se morto
		}
		
		lifes = 5;
	}	
	
}

hurt = false;

tuto=0