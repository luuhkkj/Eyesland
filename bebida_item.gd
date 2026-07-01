extends InventoryItem
class_name BebidaItem

func use(player) -> void:
	var falas = {
		0: {
			"title": "Flint",
			"dialog": "Arr, essa bebida tá boa demais!",
			"faceset": "res://icon.svg",
			"end": true
		}
	}
	DialogScreen.data = falas
	DialogScreen._id = 0
	DialogScreen.show()
	DialogScreen._initialize_dialog()
