switch (state) {
    case ENEMY_STATE.PATROL: state_patrol(); break;
    case ENEMY_STATE.CHASE:  state_chase();  break;
    case ENEMY_STATE.ATTACK: state_attack(); break;
}

// Aplica a gravidade constantemente
vsp += grv;

move_safe();

// Lógica de Transição
if (instance_exists(obj_player)) {
    var _dist_to_player = distance_to_object(obj_player);
    
    // Só muda de estado se estiver no chão
    if (place_meeting(x, y + 1, obj_solid)) {
        if (_dist_to_player <= dist_attack) {
            state = ENEMY_STATE.ATTACK;
        } else if (_dist_to_player <= dist_detect) {
            state = ENEMY_STATE.CHASE;
        } else {
            state = ENEMY_STATE.PATROL;
        }
    }
} else {
    state = ENEMY_STATE.PATROL;
}

function state_patrol() {
    hsp = dir * move_spd;

    var _wall_ahead  = place_meeting(x + hsp, y, obj_solid);
    var _enemy_ahead = place_meeting(x + hsp, y, object_index);
    
    // Checa se há chão logo à frente (com base na sprite/origem do inimigo)
    var _floor_ahead = place_meeting(x + (dir * 16), y + 1, obj_solid);

    // Se bater na parede, em outro inimigo, OU se NÃO tiver chão à frente: vira de lado
    if (_wall_ahead || _enemy_ahead || !_floor_ahead) {
        dir *= -1;
        hsp = 0;
    }
}

function state_chase() {
    if (!instance_exists(obj_player)) return;

    dir = sign(obj_player.x - x);
    hsp = dir * (move_spd * 1.5); // Corre um pouco mais rápido ao perseguir!

    // Não deixa ele cair da plataforma enquanto persegue!
    var _floor_ahead = place_meeting(x + (dir * 16), y + 1, obj_solid);
    if (!_floor_ahead || place_meeting(x + hsp, y, object_index)) {
        hsp = 0; 
    }
}

function state_attack() {
    hsp = 0; 

    if (instance_exists(obj_player)) {
        dir = sign(obj_player.x - x);
    }

    if (can_attack) {
        can_attack = false;

        var _proj = instance_create_layer(x, y, "Instances", obj_projectile); // Ajustado y-8 para sair do "peito" do inimigo
        _proj.direction = (dir == 1) ? 0 : 180;
        _proj.speed = 6;

        alarm[0] = attack_cooldown;
    }
}

function move_safe() {
    if (place_meeting(x + hsp, y, obj_solid)) {
        while (!place_meeting(x + sign(hsp), y, obj_solid)) {
            x += sign(hsp);
        }
        hsp = 0;
    }
    x += hsp;

    if (place_meeting(x, y + vsp, obj_solid)) {
        while (!place_meeting(x, y + sign(vsp), obj_solid)) {
            y += sign(vsp);
        }
        vsp = 0;
    }
    y += vsp;
}
switch (state) {
    case ENEMY_STATE.PATROL: state_patrol(); break;
    case ENEMY_STATE.CHASE:  state_chase();  break;
    case ENEMY_STATE.ATTACK: state_attack(); break;
}

// Faz o sprite virar
image_xscale = -dir;

// Aplica a gravidade constantemente
vsp += grv;

move_safe();