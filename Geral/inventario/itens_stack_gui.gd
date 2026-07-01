extends Panel
class_name ItemsStackGui

@onready var itemSprite: Sprite2D = $item
@onready var quantityLabel: Label = $QuantityLabel

var slot: inventorySlot

func update():
	if slot == null or slot.item == null:
		return
	
	itemSprite.visible = true
	itemSprite.texture = slot.item.texture
	
	quantityLabel.visible = slot.quantity > 1
	quantityLabel.text = str(slot.quantity)
