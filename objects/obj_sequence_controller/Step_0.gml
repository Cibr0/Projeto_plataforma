
if (global.sqc_morte != -1)
{
    switch (global.sqc_morte)
    {
        case 1:
            layer_sequence_create("sqc", 0, 0, sqc_morte_fadeout);
            break;

        case 0:
            layer_sequence_create("sqc", 0, 0, sqc_nextday_fadeout);
            break;
    }

    global.sqc_morte = -1;
}
