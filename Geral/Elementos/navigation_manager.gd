extends Node


const scene_acampamento = preload("res://Historia/Ato I/acampamento.tscn")
const scene_trilha = preload("res://Historia/Ato I/trilha.tscn")
const scene_praia = preload("res://Historia/Ato I/Cenariopraia.tscn")
const scene_porto = preload("res://Historia/Prologo/porto.tscn")
const scene_taverna = preload("res://Historia/Prologo/Taverna.tscn")
const scene_caverna = preload("res://Historia/Ato II/caverna3c.tscn")
const scene_antesala = preload("res://Historia/Ato II/antesala.tscn")
const scene_tunel = preload("res://Historia/Ato II/tunel.tscn")
const scene_estatua = preload("res://Historia/Ato II/estatua.tscn")


signal on_trigger_player_spawn

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
		"taverna":
			scene_to_load = scene_taverna
		"caverna":
			scene_to_load = scene_caverna
		"antesala":
			scene_to_load = scene_antesala
		"tunel":
			scene_to_load = scene_tunel
		"estatua":
			scene_to_load = scene_estatua
			
	if scene_to_load != null:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)
