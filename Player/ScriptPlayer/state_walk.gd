class_name State_walk
extends State

@export var move_speed : float = 100.0
@onready var idle : State = $"../Idle"

func Enter() -> void: 
	player.UpdateAnimation("walk")
	pass
	
func Exit() -> void:
	pass
	
func Process( _delta : float ) -> State:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
	
	return null
	
func Physiscs( _delta : float ) -> State:
	player.move_and_slide()
	return null
	
func HandleInput( _event : InputEvent ) -> State:
	return null
