class_name Player
extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine

func _ready() -> void:
	state_machine.Initialize(self)

func _physics_process(delta: float) -> void:
	direction = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if direction.x != 0:
		direction.y = 0
	elif direction.y != 0:
		direction.x = 0
	
	SetDirection()

func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	if abs(direction.x) > abs(direction.y):
		cardinal_direction = Vector2.RIGHT if direction.x > 0 else Vector2.LEFT
	else:
		cardinal_direction = Vector2.DOWN if direction.y > 0 else Vector2.UP
	
	return true

func UpdateAnimation(state_name : String) -> void:
	animation_player.play(state_name + "_" + AnimDirection())

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	else:
		return "right"
