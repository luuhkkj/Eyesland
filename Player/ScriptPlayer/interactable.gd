class_name Interactable extends Area2D

# Um sinal que será emitido quando o jogador interagir com este objeto
signal on_interact

func interact():
	emit_signal("on_interact")
	
