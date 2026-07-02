class_name infoPanel extends Control

@onready var label: Label = $Label

func mostrar(slot_gui: SlotGui) -> void:
	if slot_gui.is_empty():
		esconder()
		return

	label.text = slot_gui.item_stack.slot.item.name

	# Posiciona embaixo do slot
	var pos = slot_gui.global_position
	global_position = Vector2(pos.x, pos.y + slot_gui.size.y - 3)

	visible = true

func esconder() -> void:
	visible = false
