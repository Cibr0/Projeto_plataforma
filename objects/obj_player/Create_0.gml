//movimentação
hspd=0;
vspd=0;
spd=0;
spd_max=5;
acc=0.28;
dcc=0.28;

//gravidade e pulo
grav=0.3;
jump_height=8;
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