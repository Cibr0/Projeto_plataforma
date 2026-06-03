if (global.camera_lock > 0)
{
    global.camera_lock--;
    exit;
}

if (instance_exists(target) and !global.dying)
{
    var _myx = (target.x div gridx) * gridx;
    var _myy = (target.y div gridy) * gridy;

    max_screen_x = max(max_screen_x, _myx);

    if (first_frame)
    {
        camera_set_view_pos(view_camera[0], _myx, _myy);
        first_frame = false;
    }
    else
    {
        var _camx = lerp(camera_get_view_x(view_camera[0]), _myx, 0.05);
        var _camy = lerp(camera_get_view_y(view_camera[0]), _myy, 0.05);

        camera_set_view_pos(view_camera[0], _camx, _camy);

        global.screen_transition =
            (abs(_camx - _myx) > 2 || abs(_camy - _myy) > 2);
			
			
			
		var transition_now = (abs(_camx - _myx) > 2 || abs(_camy - _myy) > 2);

		global.screen_transition = transition_now;

		// acabou de iniciar a transição
		if (transition_now and !transition_old)
		{
		    obj_player.eco_load = false;
		    global.tema_ativo = false;
		}

		transition_old = transition_now;
    }
}

