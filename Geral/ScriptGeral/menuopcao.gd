extends Control

func _on_volume_pressed() -> void:
	get_tree().change_scene_to_file("res://Geral/ScriptGeral/Volume.tscn")

func _on_voltar_pressed() -> void:
	print(GameManager.ultima_cena)
	get_tree().change_scene_to_file(GameManager.ultima_cena)
	
func _on_sair_pressed() -> void:
	get_tree().quit()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Geral/ScriptGeral/menu.tscn")
