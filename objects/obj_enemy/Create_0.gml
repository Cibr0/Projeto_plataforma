// Enum para os estados
enum ENEMY_STATE {
    PATROL,
    CHASE,
    ATTACK
}

// Variáveis de controle
state = ENEMY_STATE.PATROL;
move_spd = 0.3;
hsp = 0;
vsp = 0;       
grv = 0.3;      
dir = 1;        // 1 = direita, -1 = esquerda

// Distâncias de detecção
dist_detect = 150;
dist_attack = 50; 

// Variáveis de combate
can_attack = true;
attack_cooldown = game_get_speed(gamespeed_fps) * 1.5;

dash_speed = 1.5;
dash_time = 20;// duração do dash
dash_timer = 0;

attack_windup = 15;// tempo de preparação
windup_timer = 0;

can_chase = true;
can_attack_player = true;