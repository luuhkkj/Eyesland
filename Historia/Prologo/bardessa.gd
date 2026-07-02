extends Node2D

# Ela não precisa checar colisões ou botão F, ela canta quando é chamada!
func iniciar_canto():
	var falas_bardessa = {
		0: {
		"title": "Bardessa",
		"dialog": "♪ (Dá um rodopio) Ninguém chega a Eyesland por engano, marujo... Não é o vento, não é o mar, não é o pano! ♪",
		"faceset": "res://bardessa.svg"
	},
	1: {
		"title": "Bardessa",
		"dialog": "♪ A ilha canta, a ilha puxa, a ilha chama... E quem escuta o seu canto, o destino já reclama! ♪",
		"faceset": "res://bardessa.svg"
	},
	2: {
		"title": "Bardessa",
		"dialog": "♪ Um navio pirata beijou os corais, afundou na tempestade e não voltou jamais... ♪",
		"faceset": "res://bardessa.svg"
	},
	3: {
		"title": "Bardessa",
		"dialog": "♪ Das tábuas partidas, sobrou este pergaminho. Um mapa rasgado para mostrar o caminho! (Ela exibe um mapa velho) ♪",
		"faceset": "res://bardessa.svg"
	},
	4: {
		"title": "Bardessa",
		"dialog": "♪ O Tesouro de Eyesland! Ouro e perigo num único traço! Será desafio para um pirata sem ninguém ao lado? ♪",
		"faceset": "res://bardessa.svg",
		"choices": [
			{"text": "Vou encontrar os destroços. Me dê o mapa.", "next_id": 5},
			{"text": "Parece uma armadilha. Qual é o preço?", "next_id": 6}
		]
	},
	5: {
		"title": "Bardessa",
		"dialog": "♪ Coragem ou loucura? O mar dirá! Leve o pedaço e veja onde vai dar! (Ela te entrega o Mapa Rasgado) ♪",
		"faceset": "res://bardessa.svg",
		"give_item": "res://Geral/inventario/itens/Mapa.tres", # <--- NOSSO GATILHO NOVO AQUI
		"end": true
	},
	6: {
		"title": "Bardessa",
		"dialog": "♪ O preço é a sua coragem! Leve, pois a ilha adora brincar com quem tem medo de naufrágio! (Ela te entrega o Mapa Rasgado) ♪",
		"faceset": "res://bardessa.svg",
		"give_item": "res://Geral/inventario/itens/Mapa.tres", # <--- NOSSO GATILHO NOVO AQUI
		"end": true
	},
	7: {
		"title": "Flint",
		"dialog": " *Você recebeu um mapa* ",
		"faceset": "res://icon.svg",
		"end": true
	}
}
	
	DialogScreen.data = falas_bardessa
	DialogScreen._id = 0
	DialogScreen.show()
	DialogScreen._initialize_dialog()
