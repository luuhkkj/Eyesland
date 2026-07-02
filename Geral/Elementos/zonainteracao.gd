# zona_interacao.gd (Vai ser o mesmo para TODOS os NPCs)
extends Area2D

func interact() -> void:
	# Pega o nó pai (o NPC) e verifica se ele sabe interagir
	if get_parent().has_method("interact"):
		get_parent().interact()
