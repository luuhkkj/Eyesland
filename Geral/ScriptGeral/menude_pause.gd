extends CanvasLayer

func _ready() -> void:
	visible = false
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Menu"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true
		
		get_viewport().set_input_as_handled()

func _on_configurações_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Geral/ScriptGeral/menuopcao.tscn")

func _on_voltar_pressed() -> void:
	visible = false
	get_tree().paused = false
