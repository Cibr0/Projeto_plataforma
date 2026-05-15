// Enum para os estados
enum ENEMY_STATE {
    PATROL,
    CHASE,
    ATTACK
}

// Variáveis de controle
state = ENEMY_STATE.PATROL;
move_spd = 2;
hsp = 0;
dir = 1; // 1 = direita, -1 = esquerda
grav = 0.4
vspd = 0

// Distâncias de detecção
dist_detect = 250;
dist_attack = 120;

// Variáveis de combate
can_attack = true;
attack_cooldown = game_get_speed(gamespeed_fps) * 2;