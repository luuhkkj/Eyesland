extends CharacterBody2D

@export var timeline_dialogo: Array[String]

func _on_interactable_on_interact() -> void:
	# Trava o jogador
	# Inicia o diálogo passando a array de textos
	DialogueManager.start_dialogue(timeline_dialogo)
