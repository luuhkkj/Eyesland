extends Node


const scene_acampamento = preload("res://História/Ato I/acampamento.tscn")
const scene_trilha = preload("res://História/Ato I/trilha.tscn")
const scene_praia = preload("res://História/Ato I/playground.tscn")
const scene_porto = preload("res://História/Ato I/porto.tscn")

var spawn_door_tag
func go_to_level(level_tag, destination_tag):
	var scene_to_load
	match level_tag:
		"acampamento":
			scene_to_load = scene_acampamento
		"trilha":
			scene_to_load = scene_trilha
		"praia":
			scene_to_load = scene_praia
		"porto":
			scene_to_load = scene_porto
			
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)
