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
			"dialog": "♪ Dizem que um pirata apostou o que não tinha, por um mapa rabiscado numa mesa de adivinha... ♪",
			"faceset": "res://bardessa.svg"
		},
		3: {
			"title": "Bardessa",
			"dialog": "♪ O Tesouro de Eyesland! Ouro para comprar um rei! Mas o preço dessa viagem... ah, isso eu não te direi. (Bate palmas no ritmo) ♪",
			"faceset": "res://bardessa.svg"
		},
		4: {
			"title": "Bardessa",
			"dialog": "♪ Então dance com as ondas, brinde ao naufrágio ideal! Conveniente é a tormenta que te joga no final! ♪",
			"faceset": "res://bardessa.svg",
			"choices": [
				{"text": "Como você sabe sobre o meu mapa?!", "next_id": 5},
				{"text": "Chega de charadas. Onde está o tesouro?", "next_id": 6}
			]
		},
		5: {
			"title": "Bardessa",
			"dialog": "♪ (Sorri de forma misteriosa) Os ventos fofocam, as marés me contaram... E os tolos que buscam, na areia ficaram! ♪",
			"faceset": "res://bardessa.svg",
			"end": true
		},
		6: {
			"title": "Bardessa",
			"dialog": "♪ O tesouro está onde o mapa terminar... mas se não souber ler a ilha, de lá nunca sairá! (Sai dançando) ♪",
			"faceset": "res://bardessa.svg",
			"end": true
		}
	}
	
	DialogScreen.data = falas_bardessa
	DialogScreen._id = 0
	DialogScreen.show()
	DialogScreen._initialize_dialog()
