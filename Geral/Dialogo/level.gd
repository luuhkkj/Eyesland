extends Node2D
class_name Level

const _DIALOG_SCREEN: PackedScene = preload("res://Geral/Dialogo/dialog_screen.tscn")

var _dialog_data: Dictionary = {
	0: {
		"faceset": "res://Geral/img/Falando1.png",
		"dialog": "Ora, ora... um rosto novo por aqui. Nunca te vi nesta taverna.",
		"title": "Barman"
	},
	
	1: {
		"faceset": "res://Geral/img/protaex.png",
		"dialog": "Primeira vez no porto. E já preciso de uma bebida.",
		"title": "Flint"
	},
	
	2: {
		"faceset": "res://Geral/img/Falando3.png",
		"dialog": "Boa. Aqui a gente faz duas coisas: serve bebida e escuta problema. Qual vai ser a sua?",
		"title": "Barman"
	}
}

@export_category("Objetcs")
@export var _hud: CanvasLayer = null

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_select") and _hud.get_child_count() == 0:
		var _new_dialog: DialogScreen = _DIALOG_SCREEN.instantiate()
		_new_dialog.data = _dialog_data
		_hud.add_child(_new_dialog)
