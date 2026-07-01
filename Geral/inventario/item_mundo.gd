# item_mundo.gd
extends Interactable   # herda de Interactable

# Aqui você arrasta o .tres do item (ex: Pinga.tres) no Inspector do Godot
@export var item_data: InventoryItem

# Carrega o mesmo inventário do player
@onready var inventory: Inventory = preload("res://Geral/inventario/PlayerInventory.tres")

func _ready():
	# Conecta o sinal on_interact (que vem do Interactable) a esta função
	on_interact.connect(_ao_interagir)

func _ao_interagir():
	if item_data:
		inventory.insert(item_data)
		queue_free()                # remove o objeto do mundo (foi coletado)
