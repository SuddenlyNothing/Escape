extends Node

onready var fade_in := $CanvasLayer/FadeIn
onready var fade_out := $CanvasLayer/FadeOut

var current_scene = null

var player = null

func _ready():
	OS.window_maximized = true
	get_current_scene()
	fade_in.fade_in()

func get_current_scene():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path, transition_texture = null, message = ""):
	get_tree().paused = true
	fade_out.fade_out(transition_texture, message)
	yield(fade_out, "faded_out")
	call_deferred("_deferred_goto_scene", path)

func reset_vars():
	player = null

func _deferred_goto_scene(path):
	# reset variables
	reset_vars()
	
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	
	# fade in transition
	fade_in.fade_in()
	fade_out.fade_out_hide()
	get_tree().paused = false

func restart(transition_texture = null, message = ""):
	goto_scene(current_scene.filename, transition_texture, message)
