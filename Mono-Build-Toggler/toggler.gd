tool
extends HBoxContainer

signal TOGGLED(new_value)

func _on_ToggleButton_toggled(button_pressed: bool) -> void:
	emit_signal("TOGGLED", button_pressed)

func set_enabled(value: bool):
	$ToggleButton.pressed = value
