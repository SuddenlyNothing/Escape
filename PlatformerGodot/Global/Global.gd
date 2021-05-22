extends Node

onready var fade_in := $CanvasLayer/FadeIn
onready var fade_out := $CanvasLayer/FadeOut

var current_scene = null

var player = null

var current_level = {
	"world":-1,
	"level":-1
}

var furthest_incomplete_level = {
	"world":-1,
	"level":-1
}

var path := "user://data.json"

var default_data = {
	"options": {
		"sfx_volume": 1,
		"master_volume": 1,
	},
	"level_data": {
		1: {
			1:false,
			2:false
		},
		2: {
			1:false,
			2:false
		}
	},
}

var data = {}

func _ready():
	print("hello")
	load_json()
	OS.window_maximized = true
	get_current_scene()
	fade_in.fade_in()

func load_json():
	var file = File.new()
	
	if not file.file_exists(path):
		data = default_data.duplicate(true)
		return
	
	file.open(path, file.READ)
	
	var text = file.get_as_text()
	
	data = parse_json(text)
	
	print(data)
	set_furthest_incomplete_level()
	
	file.close()

func save_json():
	var file
	
	file = File.new()
	
	file.open(path, File.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()

func finish_current_level():
	data["level_data"][current_level.world][current_level.level] = true
	set_furthest_incomplete_level()
	save_json()

func set_furthest_incomplete_level():
	for world in data.level_data:
		for level in data.level_data.world:
			if data.level_data.world.level == false:
				furthest_incomplete_level.world = world
				furthest_incomplete_level.level = level

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
