// Executa o comportamento do estado atual
switch (state) {
    case ENEMY_STATE.PATROL: state_patrol(); break;
    case ENEMY_STATE.CHASE:  state_chase();  break;
    case ENEMY_STATE.ATTACK: state_attack(); break;
}

// Lógica de Transição
if (instance_exists(obj_player)) {
    var _dist_to_player = distance_to_object(obj_player);

    if (_dist_to_player <= dist_attack) {
        state = ENEMY_STATE.ATTACK;
    } else if (_dist_to_player <= dist_detect) {
        state = ENEMY_STATE.CHASE;
    } else {
        state = ENEMY_STATE.PATROL;
    }
}


function state_patrol() {
    hsp = dir * move_spd;

    var _wall_ahead  = place_meeting(x + hsp, y, obj_solid);
    var _enemy_ahead = place_meeting(x + hsp, y, object_index);
    var _floor_ahead = position_empty(x + (dir * 16), bbox_bottom + 1);

    if (_wall_ahead || _enemy_ahead || _floor_ahead) {
        dir *= -1;
        hsp = 0;
    }

    move_safe();
}

function state_chase() {
    if (!instance_exists(obj_player)) return;

    dir = sign(obj_player.x - x);
    hsp = dir * move_spd;

    if (place_meeting(x + hsp, y, object_index)) {
        hsp = 0;
    }

    move_safe();
}

function state_attack() {
    hsp = 0;

    if (instance_exists(obj_player)) {
        dir = sign(obj_player.x - x);
    }

    if (can_attack) {
        can_attack = false;

        var _proj = instance_create_layer(x, y, "Instances", obj_projectile);
        _proj.direction = (dir == 1) ? 0 : 180;
        _proj.speed = 6;

        alarm[0] = attack_cooldown;
    }
	
	move_safe();
}

function move_safe() {
    if (!place_meeting(x + hsp, y, obj_solid) &&
        !place_meeting(x + hsp, y, object_index)) {
        x += hsp;
    } else {
        hsp = 0;
    }
}