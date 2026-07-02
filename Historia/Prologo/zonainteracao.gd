extends Area2D

func interact() -> void:
	if get_parent().has_method("interact"):
		get_parent().interact()
