xscale=xscale_standard*1.1
yscale=yscale_standard*1.1

switch(acao){
case "jogar":
room_goto_next()
break;

//case "opcoes":break;

case "sair":
game_end()
break;
}