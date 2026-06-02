if variable_instance_exists(id, "intro_sqc")
{
    if intro_sqc.headPosition < 99
    {
        if keyboard_check_pressed(ord("Z"))
        {
            intro_sqc.headPosition = 99;
        }
    }
}


