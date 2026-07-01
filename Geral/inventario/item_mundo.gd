# item_mundo.gd
extends Interactable

@export var item_data: InventoryItem

@onready var inventory: Inventory = preload("res://Geral/inventario/PlayerInventory.tres")

func _ready():
	on_interact.connect(_ao_interagir)

func _ao_interagir():
	if item_data:
		inventory.insert(item_data)
		queue_free()
