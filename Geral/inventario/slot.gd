extends Button

class_name SlotGui

signal hovering_started
signal hovering_ended

@onready var backgroundSprite: Sprite2D = $background
@onready var centerContainer: CenterContainer = $CenterContainer

var item_stack: ItemsStackGui = null
var index: int = 0
var inventory: Inventory = preload("res://Geral/inventario/PlayerInventory.tres")

func insert(items_stack_gui: ItemsStackGui):
	item_stack = items_stack_gui
	backgroundSprite.frame = 1
	centerContainer.add_child(item_stack)

func take_item() -> ItemsStackGui:
	var item = item_stack
	centerContainer.remove_child(item_stack)
	item_stack = null
	backgroundSprite.frame = 0
	return item

func is_empty() -> bool:
	return item_stack == null

func update(slot: inventorySlot):
	if slot.is_empty():
		backgroundSprite.frame = 0
		if item_stack != null:
			item_stack.queue_free()
			item_stack = null


func _on_mouse_entered() -> void:
	hovering_started.emit(self)


func _on_mouse_exited() -> void:
	hovering_ended.emit(self)
