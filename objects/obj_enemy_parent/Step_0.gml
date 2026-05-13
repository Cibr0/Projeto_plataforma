//Gravidade
if (!place_meeting(x, y + 1, obj_solid)) {
    vspd += grav;
}

//Verifica se o jogador existe
var _player_exists = instance_exists(obj_player);
var _dist = _player_exists ? distance_to_object(obj_player) : 9999;
var _dir_player = _player_exists ? sign(obj_player.x - x) : 0;

//Maquina de estados
switch (state) {
    case ENEMY_STATE.IDLE:
        hspd = 0;
        
        if (pode_patrulhar) { state = ENEMY_STATE.PATROL; break; }
        
        if (pode_perseguir) { state = ENEMY_STATE.CHASE; break; }
        
        if (pode_atirar) { state = ENEMY_STATE.ATTACK; break }
    break;

    case ENEMY_STATE.PATROL:
        
        hspd = dir * spd_patrol;
        
        // Inverter direção ao bater em parede ou chegar na beira de um abismo
        if (place_meeting(x + hspd, y, obj_solid) || !place_meeting(x + (dir * 16), y + 1, obj_solid)) {
            dir *= -1;
        }
    break;

    case ENEMY_STATE.CHASE:
        
        hspd = _dir_player * spd_chase;
        if (hspd != 0) dir = _dir_player;

        // Parar na beira do abismo para não cair sozinho enquanto corre
        if (!place_meeting(x + (dir * 16), y + 1, obj_solid)) {
            hspd = 0;
        }
    break;

   case ENEMY_STATE.ATTACK:
        
        // Logica de fuga
        if (_dist < flee_range) {
            hspd = -_dir_player * spd_flee;
            
            // Verificador de paredes e abismos
            var _wall_back = place_meeting(x + hspd, y, obj_solid);
            var _cliff_back = !place_meeting(x + hspd + (sign(hspd) * 10), y + 1, obj_solid);
            
            if (_wall_back || _cliff_back) {
                hspd = 0; // Se houver parede ou abismo atrás, ele para
            }
        } 
        else if (_dist > flee_range + 30) {
            // Se ele estiver muito longe do jogador, ele para pra atirar
            hspd = 0;
        }
		
        // Logica de tiro
        if (can_shoot && _dist <= shoot_range) {
            var _yy = y - 16;
            var _inst = instance_create_layer(x, _yy, "Instances", obj_projectile);
            
            _inst.speed = 4;
            _inst.direction = point_direction(x, _yy, obj_player.x, obj_player.y - 16);
            
            can_shoot = false;
            alarm[0] = fire_rate;
        }
    break;
}

// Colisão horizontal
if (place_meeting(x + hspd, y, obj_solid)) {
    while (!place_meeting(x + sign(hspd), y, obj_solid)) {
        x += sign(hspd);
    }
    hspd = 0;
}
x += hspd;

// Colisão vertical
if (place_meeting(x, y + vspd, obj_solid)) {
    while (!place_meeting(x, y + sign(vspd), obj_solid)) {
        y += sign(vspd);
    }
    vspd = 0;
}
y += vspd;