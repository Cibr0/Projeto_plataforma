//Estados
enum ENEMY_STATE {
    IDLE,       // Parado, estado base de todos os inimigos
    PATROL,     // Caminhando de um lado para o outro
    CHASE,      // Correndo atrás do jogador
    ATTACK      // Atacando à distância 
}

//Configurações de comportamento para usar nos objtos filhos
pode_patrulhar = true;
pode_perseguir = true;
pode_atirar = true;

//Variaveis de movimento
hspd = 0;           // Velocidade horizontal
vspd = 0;           // Velocidade vertical
grav = 0.4;         // Força da gravidade
dir = 1;           // Direção

// Atributos de velocidade/distancia
spd_patrol = 1;   // Velocidade de patrulha
spd_chase = 2;   // Velocidade de perseguição
spd_flee = 1.5; // Velocidade ao recuar (fugir)
detect_range = 200; // Distancia para notar o jogador
lose_range = 350; // Distância para perder o jogador de vista
shoot_range = 250; // Distância ideal para começar a atirar
flee_range = 100; // Distância para o inimigo recuar

//Logica de disparo
can_shoot = true;
fire_rate = game_get_speed(gamespeed_fps) * 2; // Tempo entre tiros (2 segundos)

//Estado Inicial 
state = ENEMY_STATE.IDLE