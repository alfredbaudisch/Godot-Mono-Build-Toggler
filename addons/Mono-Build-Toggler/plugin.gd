tool
extends EditorPlugin

var scene: Node
var SOLUTION_PATH: String
var SOLUTION_PATH_HIDDEN: String

func _enter_tree():
	
	SOLUTION_PATH = "res://" + ProjectSettings.get("application/config/name") + ".sln"
	SOLUTION_PATH_HIDDEN = "res://" + ProjectSettings.get("application/config/name") + ".sln.disabled" # Change this value to customise the hidden file's name
	
	scene = preload("toggler.tscn").instance()
	scene.connect("TOGGLED", self, "_on_mono_toggled")
	
	add_control_to_container(CONTAINER_TOOLBAR, scene)
	
	# Set toggle button initial status
	var file: File = File.new()
	if file.file_exists(SOLUTION_PATH):
		scene.set_enabled(true)
	elif file.file_exists(SOLUTION_PATH_HIDDEN):
		scene.set_enabled(false)
	else:
		push_error("No solution file exists at path '" + SOLUTION_PATH + "' or '" + SOLUTION_PATH_HIDDEN + "'")

func _on_mono_toggled(enabled: bool):
	var dir: Directory = Directory.new()
	if not enabled:
		if dir.file_exists(SOLUTION_PATH):
			# Hide solution file
			var error: int = dir.rename(SOLUTION_PATH, SOLUTION_PATH_HIDDEN)
			if error != OK:
				push_error("An error occurred while renaming the solution file: " + str(error))
				return
		elif not dir.file_exists(SOLUTION_PATH_HIDDEN):
			push_error("No solution file exists at path '" + SOLUTION_PATH + "' or '" + SOLUTION_PATH_HIDDEN + "'")
	else:
		if dir.file_exists(SOLUTION_PATH_HIDDEN):
			# Show solution file
			var error: int = dir.rename(SOLUTION_PATH_HIDDEN, SOLUTION_PATH)
			if error != OK:
				push_error("An error occurred while renaming the solution file: " + str(error))
				return
		elif not dir.file_exists(SOLUTION_PATH):
			push_error("No solution file exists at path '" + SOLUTION_PATH + "' or '" + SOLUTION_PATH_HIDDEN + "'")

func _exit_tree():
	remove_control_from_container(CONTAINER_TOOLBAR, scene)
	scene.free()

	# Enable solution if disabled
	var dir: Directory = Directory.new()
	if dir.file_exists(SOLUTION_PATH_HIDDEN):
		dir.rename(SOLUTION_PATH_HIDDEN, SOLUTION_PATH)
