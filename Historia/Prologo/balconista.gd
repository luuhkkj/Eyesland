extends Node2D # Pode ser CharacterBody2D dependendo de como você criou o Balconista

var jogador_na_area = false

# Função acionada quando algo entra no retângulo do Interactable
func _on_interactable_body_entered(body):
	# Verifica se quem entrou foi o jogador (ajuste "Player" se o seu nó tiver outro nome)
	if body.name == "Player":
		jogador_na_area = true

# Função acionada quando algo sai do retângulo
func _on_interactable_body_exited(body):
	if body.name == "Player":
		jogador_na_area = false

# Escuta os comandos do teclado o tempo todo
func _unhandled_input(event):
	# Se o jogador estiver na área E apertar a tecla configurada como "interagir" (F)
	if jogador_na_area and event.is_action_pressed("interagir"):
		iniciar_conversa()

func iniciar_conversa():
	# 1. Primeiro criamos a variável com os textos e escolhas
	var falas_teste = {
		0: {
			"title": "Balconista",
			"dialog": "Ahoy, marujo! O que te traz à minha taverna hoje?",
			"faceset": "res://icon.svg",
			"choices": [
				{"text": "Estou procurando pistas sobre um naufrágio...", "next_id": 1},
				{"text": "Apenas um caneco de rum, por favor.", "next_id": 2}
			]
		},
		1: {
			"title": "Balconista",
			"dialog": "Naufrágio, eh? As águas andam traiçoeiras. Aqueles recifes escondem muitos segredos.",
			"faceset": "res://icon.svg",
			"end": true # <--- AVISO DE FIM DE ROTA
		},
		2: {
			"title": "Balconista",
			"dialog": "Saindo um caneco do nosso melhor rum para acalmar a tempestade!",
			"faceset": "res://icon.svg",
			"end": true # <--- AVISO DE FIM DE ROTA
		}
	}
	
	# 2. Depois enviamos a variável para a interface e mandamos abrir
	DialogScreen.data = falas_teste
	DialogScreen._id = 0
	DialogScreen.show()
	DialogScreen._initialize_dialog()
