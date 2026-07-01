extends Resource
class_name inventorySlot

@export var item: InventoryItem = null
@export var quantity: int = 0

func is_empty() -> bool:
	return item == null or quantity <= 0

func can_add_more() -> bool:
	if item == null:
		return false
	return quantity < item.max_stack
