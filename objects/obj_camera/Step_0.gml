if (instance_exists(target)) {
	//variaveis para saber a posição do player na grid
	var _myx, _myy;
	
	//achando minha posição dentro da grid
    _myx = (target.x div gridx) * gridx;
	_myy = (target.y div gridy) * gridy;

    var _camx = lerp(camera_get_view_x(view_camera[0]),_myx,0.05);
	var _camy = lerp(camera_get_view_y(view_camera[0]),_myy,0.05);

    camera_set_view_pos(view_camera[0], _camx, _camy);
	
}