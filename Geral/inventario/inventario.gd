extends Control

var is0open: bool = false

@onready var inventory: Inventory = preload("res://Geral/inventario/PlayerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	inventory.item_adicionado.connect(update)  # quando item entrar, chama update()
	update()

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i]) 

func open():
	visible = true
	is0open = true

func close():
	visible = false
	is0open = false
