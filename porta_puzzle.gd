extends Node2D  # ou StaticBody2D, Area2D, o que usar na porta

@export var chave_id: String = "chave_sala_01"  # define no Inspector

@onready var inventory: Inventory = preload("res://Geral/inventario/PlayerInventory.tres")

# Chama isso quando o player interagir com a porta (pelo sistema Interactable)
func tentar_abrir():
	if inventory.has_item(chave_id):
		inventory.remove_item_by_name(chave_id)
		abrir_porta()
	else:
		print("Precisa de uma chave para abrir isso...")
		# ex: exibir dica visual ou diálogo

func abrir_porta():
	print("Porta aberta!")
	# ex: $CollisionShape2D.disabled = true
	# ex: $AnimationPlayer.play("abrir")
	# ex: queue_free()
