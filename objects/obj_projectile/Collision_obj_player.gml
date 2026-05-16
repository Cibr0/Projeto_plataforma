with (other)
{
    damage(1);
}

if (other.x < x)
{
    other.hspd = -4;
}
else
{
    other.hspd = 4;
}

other.vspd = -4;

other.hurt = true;

instance_destroy();