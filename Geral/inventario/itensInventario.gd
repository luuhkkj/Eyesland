extends Resource
class_name InventoryItem

@export var name: String = ""
@export var texture: Texture2D
@export var max_stack: int = 1

# Método base — cada tipo de item sobrescreve
func use(player) -> void:
	pass
