extends HSlider

@export var bus_name: String = "Master"

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

	if bus_index == -1:
		push_error("Barramento '%s' não encontrado!" % bus_name)
		return

	if !value_changed.is_connected(_on_value_changed):
		value_changed.connect(_on_value_changed)

	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))


func _on_value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(new_value)
	)
