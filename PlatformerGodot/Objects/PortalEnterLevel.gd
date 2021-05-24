extends Portal

export(int) var scene_level := -1

func _ready():
	assert( scene_level != -1, "ERROR: scene_level must be greater than 0.")

func goto_next_scene():
	Global.current_level.world = owner.world_num
	Global.current_level.level = scene_level
	Global.goto_scene(next_scene)
	Global.start_level_music()
