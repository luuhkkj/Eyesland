extends Control


func _on_volume_pressed() -> void:
	pass # Replace with function body.


func _on_menu_pressed() -> void:
		get_tree().change_scene_to_file("res://Geral/ScriptGeral/menu.tscn")


func _on_sair_pressed() -> void:
	get_tree().quit()
