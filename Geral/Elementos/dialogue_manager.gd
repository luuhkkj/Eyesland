extends CanvasLayer

var dialog_lines : Array[String] = []
var current_line_index = 0

@onready var text_label = $Background/HContainer/VContainer/Dialog
@onready var box = $Background

func start_dialogue(lines: Array[String]):
	dialog_lines = lines
	current_line_index = 0
	box.show()
	show_line()
	# Aqui você muda o estado do Player para State_Locked

func show_line():
	text_label.text = dialog_lines[current_line_index]

func _unhandled_input(event):
	if event.is_action_pressed("interagir") and box.visible:
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			box.hide()
			# Retorna o Player para State_Idle
		else:
			show_line()
