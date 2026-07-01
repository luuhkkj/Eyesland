extends Resource
class_name Inventory

@export var slots: Array[inventorySlot]

signal item_adicionado
signal use_item(item: InventoryItem)  # emite o item quando usado

func insert(item: InventoryItem) -> bool:
	for slot in slots:
		if slot != null and slot.item != null:
			if slot.item.name == item.name and slot.can_add_more():
				slot.quantity += 1
				emit_signal("item_adicionado")
				return true
	for slot in slots:
		if slot != null and slot.is_empty():
			slot.item = item
			slot.quantity = 1
			emit_signal("item_adicionado")
			return true
	print("Inventário cheio!")
	return false

func remove_slot(inv_slot: inventorySlot):
	var idx = slots.find(inv_slot)
	if idx < 0:
		return
	remove_at_index(idx)

func remove_at_index(index: int):
	slots[index] = inventorySlot.new()
	emit_signal("item_adicionado")  # força atualizar a UI

func use_item_at_index(index: int):
	print("use_item_at_index chamado, index: ", index)
	print("slots.size(): ", slots.size())
	
	if index < 0 or index >= slots.size():
		print("ERRO: índice fora do range")
		return
	
	var slot = slots[index]
	print("slot: ", slot)
	print("slot.is_empty(): ", slot.is_empty())
	
	if slot == null or slot.is_empty():
		print("ERRO: slot vazio ou null")
		return

	print("item no slot: ", slot.item)
	print("item.name: ", slot.item.name)
	
	emit_signal("use_item", slot.item)

	if slot.quantity > 1:
		slot.quantity -= 1
		emit_signal("item_adicionado")
	else:
		remove_at_index(index)

func has_item(item_name: String) -> bool:
	for slot in slots:
		if slot != null and slot.item != null:
			if slot.item.name == item_name:
				return true
	return false

func remove_item_by_name(item_name: String) -> bool:
	for i in range(slots.size()):
		if slots[i] != null and slots[i].item != null:
			if slots[i].item.name == item_name:
				if slots[i].quantity > 1:
					slots[i].quantity -= 1
					emit_signal("item_adicionado")
				else:
					remove_at_index(i)
				return true
	return false
