extends Node

onready var fade_in := $CanvasLayer/FadeIn
onready var fade_out := $CanvasLayer/FadeOut

onready var options_menu := $CanvasLayer/Options

var previous_scene = null
var current_scene = null
var did_intro_cutscene = false

var player = null

var world_checkpoint = {
	"world":null,
	"player_pos":null,
}

var level_checkpoint = null

var current_level = {
	"world":-1,
	"level":-1
}

var furthest_incomplete_level = {
	"world":1,
	"level":1
}

var path := "user://data.json"

var default_data = {
	"volume": {
		"Master": 1,
		"SFX": 1,
		"Music": 1,
	},
	"level_data": {
		1: {
			1:false,
			2:false,
			3:false,
		},
		2: {
			1:false,
			2:false,
			3:false,
		},
		3: {
			1:false,
			2:false,
			3:false,
		},
	},
	"did_intro_cutscene":false,
}

var data = {}

func _ready():
	get_tree().paused = true
	load_json()
	OS.window_maximized = true
	get_current_scene()
	fade_in.fade_in()
	yield(fade_in, "faded_in")
	get_tree().paused = false

func load_json():
	var file = File.new()
	
	if not file.file_exists(path):
		data = default_data.duplicate(true)
		return
	
	file.open(path, file.READ)
	
	var text = file.get_as_text()
	
	data = parse_json(text)
	
	did_intro_cutscene = data.did_intro_cutscene
	set_furthest_incomplete_level()
	for audio_bus_name in data.volume:
		set_volume(audio_bus_name, data.volume[audio_bus_name])
	
	file.close()

func save_json():
	var file
	
	file = File.new()
	
	file.open(path, File.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()

func finish_current_level():
	data.level_data[str(current_level.world)][str(current_level.level)] = true
	set_furthest_incomplete_level()
	current_level = {
		"world":-1,
		"level":-1
	}
	save_json()

func set_furthest_incomplete_level():
	for world in data.level_data:
		for level in data.level_data[world]:
			if data.level_data[world][level] == false:
				furthest_incomplete_level.world = int(world)
				furthest_incomplete_level.level = int(level)
				return

func get_current_scene():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	options_menu.exit()
	reset_level_vars()
	get_tree().paused = true
	fade_out.fade_out()
	yield(fade_out, "faded_out")
	call_deferred("_deferred_goto_scene", path)

func reset_scene_vars():
	player = null

func reset_level_vars():
	level_checkpoint = null

func _deferred_goto_scene(path):

	# reset variables that differ from each scene
	reset_scene_vars()
	
	# It is now safe to remove the current scene
	previous_scene = current_scene.filename
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene. Set previous_scene as current_scene
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	
	# fade in transition
	fade_in.fade_in()
	fade_out.fade_out_hide()
	yield(fade_in, "faded_in")
	get_tree().paused = false

func restart(transition_texture = null, message = ""):
	options_menu.exit()
	get_tree().paused = true
	fade_out.fade_out(transition_texture, message)
	yield(fade_out, "faded_out")
	call_deferred("_deferred_goto_scene", current_scene.filename)

func goto_previous_scene():
	goto_scene(previous_scene)

func options_menu_enter():
	options_menu.enter()

func options_menu_exit():
	options_menu.exit()

func set_volume(audio_bus_name, value):
	var bus := AudioServer.get_bus_index(audio_bus_name)
	AudioServer.set_bus_volume_db(bus, linear2db(value))
	data.volume[audio_bus_name] = value
	save_json()

func complete_intro_cutscene():
	did_intro_cutscene = true
	data.did_intro_cutscene = true
	save_json()
