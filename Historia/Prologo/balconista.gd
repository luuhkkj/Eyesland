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
			"title": "Gragas",
			"dialog": "Ora, ora... um rosto novo por aqui. Nunca te vi nesta taverna.",
			"faceset": "res://gragas.svg"
		},
		1: {
			"title": "Flint",
			"dialog": "Primeira vez no porto. E já preciso de uma bebida.",
			"faceset": "res://icon.svg"
		},
		2: {
			"title": "Gragas",
			"dialog": "Boa. Aqui a gente faz duas coisas: serve bebida e escuta problema. Qual vai ser a sua?",
			"faceset": "res://gragas.svg",
			"choices": [
				{"text": "Vou querer uma pinga paizão", "next_id": 3}, # Aponta para a resposta da pinga
				{"text": "Apenas um caneco de rum, por favor.", "next_id": 4}  # Aponta para a resposta do rum
			]
		},
		3: {
			"title": "Gragas",
			"dialog": "A bebida só é um problema quando a caneca está vazia! HAHA! (Te serve a pinga)",
			"faceset": "res://gragas.svg",
			"end": true # Finaliza a conversa se escolher pinga
		},
		4: { # <-- Criamos um ID 4 exclusivo para a resposta do Rum
			"title": "Gragas",
			"dialog": "Eu quero ver beber mais do que eu! (Te serve um caneco de rum)",
			"faceset": "res://gragas.svg",
			"end": true # Finaliza a conversa se escolher rum
		}
	}
	
	# 2. Depois enviamos a variável para a interface e mandamos abrir
	DialogScreen.data = falas_teste
	DialogScreen._id = 0
	DialogScreen.show()
	DialogScreen._initialize_dialog()
