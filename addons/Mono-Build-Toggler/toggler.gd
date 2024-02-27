@tool
class_name MonoBuildToggler
extends HBoxContainer

signal TOGGLED(new_value)


func _on_ToggleButton_toggled(button_pressed: bool) -> void:
	TOGGLED.emit(button_pressed)


func set_enabled(value: bool):
	$ToggleButton.set_pressed_no_signal(value)
