if (instance_exists(target))
{
    var _myx = (target.x div gridx) * gridx;
    var _myy = (target.y div gridy) * gridy;

    var _camx = lerp(camera_get_view_x(view_camera[0]), _myx, 0.05);
    var _camy = lerp(camera_get_view_y(view_camera[0]), _myy, 0.05);

    camera_set_view_pos(view_camera[0], _camx, _camy);

    //Detecta se a câmera ainda está se movendo
    if (abs(_camx - _myx) > 2 || abs(_camy - _myy) > 2)
    {
        global.screen_transition = true;
    }
    else
    {
        global.screen_transition = false;
    }
}