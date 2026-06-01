switch (state) {
    case ENEMY_STATE.PATROL: state_patrol(); break;
    case ENEMY_STATE.CHASE:  state_chase();  break;
    case ENEMY_STATE.ATTACK: state_attack(); break;
}



//Faz o sprite virar
image_xscale = -dir;

//Aplica a gravidade constantemente
vsp += grv;

move_safe();
if (state == ENEMY_STATE.ATTACK) {
    exit;
}
// Lógica de Transição
if (instance_exists(obj_player)) {
    var _dist_to_player = distance_to_object(obj_player);
	var _dx = abs(obj_player.x - x);
	var _dy = abs(obj_player.y - y);
    
    // Só muda de estado se estiver no chão
if (place_meeting(x, y + 1, obj_solid)) {
    if (_dx <= dist_attack and _dy <= 24 and can_attack) {
	state = ENEMY_STATE.ATTACK;
	}
	else if (_dx <= dist_detect and _dy <= 24) {
		state = ENEMY_STATE.CHASE;
	}
	else {
		state = ENEMY_STATE.PATROL;
		}
    }
}

function state_patrol() {
	sprite_index = spr_enemy_walk;
    hsp = dir * move_spd;

   var _wall_ahead =
    place_meeting(x + hsp, y, obj_solid) ||
    place_meeting(x + hsp, y, obj_coll_plataform);
    var _enemy_ahead = place_meeting(x + hsp, y, object_index);
    
    //Checa se há chão logo à frente (com base na sprite/origem do inimigo)
    var _floor_ahead = place_meeting(x + (dir * 16), y + 1, obj_solid);

    //Se bater na parede, em outro inimigo, OU se NÃO tiver chão à frente: vira de lado
    if (_wall_ahead || _enemy_ahead || !_floor_ahead) {
        dir *= -1;
        hsp = 0;
    }
}

function state_chase() {
    if (!instance_exists(obj_player)) return;

    var _dx = obj_player.x - x;

    if (_dx > 8)
        dir = 1;
    else if (_dx < -8)
        dir = -1;

   var _floor_ahead =
    place_meeting(x + (dir * 16), y + 1, obj_solid) ||
    place_meeting(x + (dir * 16), y + 1, obj_coll_plataform);

    //Não se joga no precipício
    	 if (!_floor_ahead) {
        dash_timer = 0;
        hsp = 0;
        state = ENEMY_STATE.PATROL;
        return;
    }

    hsp = dir * (move_spd * 1.5);
}

function state_attack() {

    if (instance_exists(obj_player)) {
        dir = sign(obj_player.x - x);
    }

    //Inicia o ataque
    if (can_attack) {
        can_attack = false;

        windup_timer = attack_windup;
        dash_timer = dash_time;

        alarm[0] = attack_cooldown;
    }

    //Preparação
if (windup_timer > 0) {

    //Jogador saiu do alcance?
    if (distance_to_object(obj_player) > dist_attack) {

        attack_started = false;
        windup_timer = 0;
        dash_timer = 0;

        state = ENEMY_STATE.CHASE;

        return;
    }

    sprite_index = spr_enemy;

    hsp = 0;
    windup_timer--;

    return;
}

    // Investida
if (dash_timer > 0) {

    sprite_index = spr_enemy_walk;
	
	var _floor_ahead = place_meeting(x + (dir * 16), y + 1, obj_solid);
	
	 if (!_floor_ahead) {
        dash_timer = 0;
        hsp = 0;
        state = ENEMY_STATE.PATROL;
        return;
    }
	
    hsp = dir * dash_speed;

	/*
	// Acertou o jogador?
    if (place_meeting(x + hsp, y, obj_player)) {
        // dano
    }
	*/
	
    // Bateu na parede?
    if (place_meeting(x + hsp, y, obj_solid)) {
        dash_timer = 0;
        hsp = 0;
    }

    dash_timer--;

    return;
}}

function move_safe() {

    // Horizontal
    if (
        place_meeting(x + hsp, y, obj_solid) ||
        place_meeting(x + hsp, y, obj_coll_plataform)
    ) {

        while (
            !place_meeting(x + sign(hsp), y, obj_solid) &&
            !place_meeting(x + sign(hsp), y, obj_coll_plataform)
        ) {
            x += sign(hsp);
        }

        hsp = 0;
    }

    x += hsp;

    // Vertical
    if (
        place_meeting(x, y + vsp, obj_solid) ||
        place_meeting(x, y + vsp, obj_coll_plataform)
    ) {

        while (
            !place_meeting(x, y + sign(vsp), obj_solid) &&
            !place_meeting(x, y + sign(vsp), obj_coll_plataform)
        ) {
            y += sign(vsp);
        }

        vsp = 0;
    }

    y += vsp;
}


