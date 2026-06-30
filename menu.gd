extends Control


func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://Historia/Prologo/Taverna.tscn")


func _on_configuracoes_pressed() -> void:
	get_tree().change_scene_to_file("res://Geral/ScriptGeral/meduopcao_conf.tscn")
	

func _on_sair_pressed() -> void:
	get_tree().quit()


func _on_creditos_pressed() -> void:
	pass # Replace with function body.
