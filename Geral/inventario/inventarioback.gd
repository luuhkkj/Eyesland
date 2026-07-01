extends Resource
class_name Inventory

@export var items: Array[InventoryItem]

signal item_adicionado

func insert(item: InventoryItem):
	items.append(item)
	emit_signal("item_adicionado")   # só isso — sem ResourceSaver
