if (global.camera_lock > 0)
{
    global.camera_lock--;
    exit;
}

if (instance_exists(target) && !global.dying)
{
    var _myx = (target.x div gridx) * gridx;
    var _myy = (target.y div gridy) * gridy;

    max_screen_x = max(max_screen_x, _myx);

    // 🔥 FIRST FRAME SNAP
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
    }
}