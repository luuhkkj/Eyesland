extends CanvasLayer

@onready var inventory = $Inventario

func _ready():
	inventory.close()

func _input(event):
	if event.is_action_pressed("Inventario"):
		if inventory.is_open:
			inventory.close()
		else:
			inventory.open()
