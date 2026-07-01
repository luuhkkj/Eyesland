extends Node2D # Pode ser CharacterBody2D dependendo de como você criou o Balconista

var jogador_na_area = false
# Escuta os comandos do teclado o tempo todo
func _unhandled_input(event):
	# Se o jogador estiver na área E apertar a tecla configurada como "interagir" (F)
	if jogador_na_area and event.is_action_pressed("interagir"):
		iniciar_conversa()
		
func _on_interactive_body_entered(body: Node2D) -> void:
	# Verifica se quem entrou foi o jogador (ajuste "Player" se o seu nó tiver outro nome)
	if body.name == "Player":
		jogador_na_area = true


func _on_interactive_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		jogador_na_area = false

func iniciar_conversa():
	# 1. Primeiro criamos a variável com os textos e escolhas
	var falas_teste = {
		0: {
			"title": "Flint",
			"dialog": "Um diário no meio dessa floresta?",
			"faceset": "res://icon.svg",
			"choices": [
				{"text": "Ler Diário", "next_id": 1},
			
			]
		},
		1: {
			"title": "Diario",
			"dialog": "Já faz dias que meu barco quebrou nessa ilha, não aguento mais esperar ajuda",
			"faceset": "res://icon.svg",
			"choices": [
				{"text": "continuar lendo", "next_id": 2},
				
				]
			 
		},
		2: {
			"title": "Diário",
			"dialog": "Irei continuar a trilha e entrar naquela caverna",
			"faceset": "res://icon.svg",
			"choices": [
				{"text": "continuar lendo", "next_id": 3},
			]
			
		},
		3: {
			"title": "Diário",
			"dialog": "Tem que ter alguma saída desse inferno",
			"faceset": "res://icon.svg",
			
			"end": true 
		}
		
	}
	
	# 2. Depois enviamos a variável para a interface e mandamos abrir
	DialogScreen.data = falas_teste
	DialogScreen._id = 0
	DialogScreen.show()
	DialogScreen._initialize_dialog()
	
	
	
	
