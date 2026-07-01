extends InventoryItem
class_name ChaveItem

# Identificador único da chave — define no Inspector
# ex: "chave_sala_01", "chave_calabouco"
@export var chave_id: String = ""

func use(player) -> void:
	# Chaves não são usadas diretamente — são consumidas pela porta
	pass
