@tool
extends EditorPlugin

var button : Button

func _enter_tree() -> void:
	# Create a decent button.
	button = Button.new()
	button.focus_mode = Control.FOCUS_NONE
	button.icon = get_editor_interface().get_editor_theme().get_icon("PlayStart", "EditorIcons")
	button.shortcut = __create_shortcut(KEY_F5, true)
	button.shortcut_in_tooltip = false
	button.tooltip_text = "\n".join([
		"Fast Run Project (%s)" % button.shortcut.get_as_text(),
		"Run the project without rebuilding."
	])
	# Add it to the container.
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, button)
	# Bind an actual action to the button.
	button.pressed.connect(__when_button_pressed)


func _exit_tree() -> void:
	if button == null:
		return
	# Tear everything down.
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, button)
	button.free()
	button = null


func __when_button_pressed() -> void:
	get_editor_interface().save_all_scenes()
	OS.create_process(OS.get_executable_path(), ["--path", ProjectSettings.globalize_path("res://")])


func __create_shortcut(keycode : Key, shift_pressed : bool) -> Shortcut:
	var ev := InputEventKey.new()
	ev.pressed = true
	ev.shift_pressed = shift_pressed
	ev.keycode = keycode
	var shortcut := Shortcut.new()
	shortcut.events.append(ev)
	return shortcut
