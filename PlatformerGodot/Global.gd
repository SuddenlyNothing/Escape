extends Node

var current_scene = null

var player = null

func _ready():
	OS.window_maximized = true
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func reset_vars():
	player = null

func _deferred_goto_scene(path):
	reset_vars()
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

func restart():
	goto_scene(current_scene.filename)
