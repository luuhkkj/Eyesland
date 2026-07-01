class_name Player
extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine
@onready var detect_area : Area2D = $DetectArea

@export var inventory: Inventory

func _ready() -> void:
	state_machine.Initialize(self)
	inventory.use_item.connect(_ao_usar_item)

func _ao_usar_item(item: InventoryItem) -> void:
	item.use(self)

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

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir"):
		var overlaps = detect_area.get_overlapping_areas()
		for area in overlaps:
			if area is Interactable:
				area.interact()
				break

	if event.is_action_pressed("usar_item"):
		var inventario_ui = get_tree().get_first_node_in_group("inventario_ui")
		if inventario_ui and inventario_ui.slot_selecionado >= 0:
			inventory.use_item_at_index(inventario_ui.slot_selecionado)
