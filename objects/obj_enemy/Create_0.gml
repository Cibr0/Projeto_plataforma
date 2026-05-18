// Enum para os estados
enum ENEMY_STATE {
    PATROL,
    CHASE,
    ATTACK
}

// Variáveis de controle
state = ENEMY_STATE.PATROL;
move_spd = 0.5;
hsp = 0;
vsp = 0;       
grv = 0.3;      
dir = 1;        // 1 = direita, -1 = esquerda

// Distâncias de detecção
dist_detect = 150;
dist_attack = 30; 

// Variáveis de combate
can_attack = true;
attack_cooldown = game_get_speed(gamespeed_fps) * 1.5;