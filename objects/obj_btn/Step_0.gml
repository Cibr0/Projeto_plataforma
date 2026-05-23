switch(acao){
case "jogar":
sprite_index=spr_jogar
break;

case "opcoes":
sprite_index=spr_opcoes
break;

case "sair":
sprite_index=spr_sair
break;
}

scr_sequences()

xscale=lerp(xscale,xscale_standard,0.1)
yscale=lerp(yscale,yscale_standard,0.1)

