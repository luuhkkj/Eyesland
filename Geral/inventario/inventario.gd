extends Control

const ITEM_STACK_GUI = preload("res://Geral/inventario/itensStackGui.tscn")

var is_open: bool = false
var item_na_mao: ItemsStackGui = null
var indice_slot_anterior: int = -1
var travado: bool = false
var slot_selecionado: int = -1

@onready var inventory: Inventory = preload("res://Geral/inventario/PlayerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var info_panel: infoPanel = $Control

func _ready():
	add_to_group("inventario_ui")
	for i in range(inventory.slots.size()):
		if inventory.slots[i] == null:
			inventory.slots[i] = inventorySlot.new()
	conectar_slots()
	inventory.item_adicionado.connect(atualizar_ui)
	atualizar_ui()

func _input(event):
	atualizar_item_na_mao()
	if item_na_mao != null and event.is_action_pressed("right_click"):
		devolver_item()

func conectar_slots():
	for i in range(slots.size()):
		var slot_gui: SlotGui = slots[i]
		slot_gui.index = i
		slot_gui.pressed.connect(on_slot_clicado.bind(slot_gui))
		slot_gui.mouse_entered.connect(_selecionar_slot.bind(slot_gui))
		slot_gui.mouse_exited.connect(_desselecionar_slot)

func _selecionar_slot(slot_gui: SlotGui):
	if item_na_mao != null:
		return
	slot_selecionado = slot_gui.index

func _desselecionar_slot():
	if item_na_mao != null:
		return
	slot_selecionado = -1

func on_slot_clicado(slot_gui: SlotGui):
	if travado:
		return

	if slot_gui.is_empty():
		if item_na_mao == null:
			return
		inserir_item_no_slot(slot_gui)
		return

	if item_na_mao == null:
		pegar_item_do_slot(slot_gui)
		return

	if item_na_mao.slot.item.name == slot_gui.item_stack.slot.item.name:
		empilhar_items(slot_gui)
		return

	trocar_items(slot_gui)

func pegar_item_do_slot(slot_gui: SlotGui):
	indice_slot_anterior = slot_gui.index
	item_na_mao = slot_gui.take_item()
	inventory.slots[slot_gui.index] = inventorySlot.new()
	add_child(item_na_mao)
	atualizar_item_na_mao()

func inserir_item_no_slot(slot_gui: SlotGui):
	var item = item_na_mao
	remove_child(item_na_mao)
	item_na_mao = null
	indice_slot_anterior = -1
	slot_gui.insert(item)
	inventory.slots[slot_gui.index] = item.slot

func trocar_items(slot_gui: SlotGui):
	var item_temporario = slot_gui.take_item()
	var slot_salvo = inventory.slots[slot_gui.index]
	inserir_item_no_slot(slot_gui)
	item_na_mao = item_temporario
	item_na_mao.slot = slot_salvo
	add_child(item_na_mao)
	atualizar_item_na_mao()

func empilhar_items(slot_gui: SlotGui):
	var stack_no_slot = slot_gui.item_stack
	var max_stack = stack_no_slot.slot.item.max_stack
	var total = stack_no_slot.slot.quantity + item_na_mao.slot.quantity

	if stack_no_slot.slot.quantity >= max_stack:
		trocar_items(slot_gui)
		return

	if total <= max_stack:
		stack_no_slot.slot.quantity = total
		remove_child(item_na_mao)
		item_na_mao = null
		indice_slot_anterior = -1
	else:
		item_na_mao.slot.quantity = total - max_stack
		stack_no_slot.slot.quantity = max_stack

	stack_no_slot.update()
	if item_na_mao != null:
		item_na_mao.update()

func devolver_item():
	travado = true

	if indice_slot_anterior < 0 or !slots[indice_slot_anterior].is_empty():
		var slots_vazios = inventory.slots.filter(func(s): return s != null and s.is_empty())
		if slots_vazios.is_empty():
			travado = false
			return
		for i in range(inventory.slots.size()):
			if inventory.slots[i] != null and inventory.slots[i].is_empty():
				indice_slot_anterior = i
				break

	var slot_destino: SlotGui = slots[indice_slot_anterior]

	var tween = get_tree().create_tween()
	var posicao_alvo = slot_destino.global_position + slot_destino.size / 2 - item_na_mao.size / 2
	tween.tween_property(item_na_mao, "global_position", posicao_alvo, 0.2)
	await tween.finished

	inserir_item_no_slot(slot_destino)
	travado = false

func atualizar_item_na_mao():
	if item_na_mao == null:
		return
	item_na_mao.position = get_local_mouse_position() - item_na_mao.size / 2

func atualizar_ui():
	for i in range(slots.size()):
		if i >= inventory.slots.size():
			break

		if inventory.slots[i] == null:
			inventory.slots[i] = inventorySlot.new()

		var inv_slot = inventory.slots[i]
		var slot_gui = slots[i]

		if inv_slot.is_empty():
			slot_gui.update(inv_slot)
			continue

		if slot_gui.item_stack == null:
			var novo_stack = ITEM_STACK_GUI.instantiate()
			slot_gui.insert(novo_stack)

		slot_gui.item_stack.slot = inv_slot
		slot_gui.item_stack.update()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
	
func hovering_started(slot: SlotGui) -> void:
	info_panel.mostrar(slot)

func hovering_ended() -> void:
	info_panel.esconder()
	
func _process(_delta):
	if item_na_mao != null:
		info_panel.esconder()
		return

	var mouse = get_global_mouse_position()
	var em_slot_com_item = false

	for slot_gui in slots:
		if slot_gui.get_global_rect().has_point(mouse) and not slot_gui.is_empty():
			info_panel.mostrar(slot_gui)
			em_slot_com_item = true
			break

	if not em_slot_com_item:
		info_panel.esconder()
