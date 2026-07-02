class_name Player
extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var objeto_interativo_atual = null

@onready var balao_interacao = $BalaoInteracao
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine
@onready var detect_area : Area2D = $DetectArea

@export var inventory: Inventory

func _ready() -> void:
	state_machine.Initialize(self)
	balao_interacao.hide()
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


func _on_detect_area_area_entered(area):
	# Perguntamos se a área possui a função "interact" dentro do script dela
	if area.has_method("interact"):
		objeto_interativo_atual = area
		balao_interacao.show()
		_animar_balao() 

func _on_detect_area_area_exited(area):
	# Mesma checagem para quando sair de perto
	if area.has_method("interact") and area == objeto_interativo_atual:
		objeto_interativo_atual = null
		balao_interacao.hide()

func _input(event):
	# Se apertar F (ajuste o nome "interagir" para o nome da sua Input Map se for diferente)
	if event.is_action_pressed("interagir") and objeto_interativo_atual != null:
		objeto_interativo_atual.interact() 
		balao_interacao.hide() 

func _animar_balao():
	# Faz o balão flutuar suavemente em cima do Flint
	var pos_original = balao_interacao.position
	var tween = create_tween().set_loops()
	tween.tween_property(balao_interacao, "position:y", pos_original.y - 4, 0.4).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(balao_interacao, "position:y", pos_original.y, 0.4).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
