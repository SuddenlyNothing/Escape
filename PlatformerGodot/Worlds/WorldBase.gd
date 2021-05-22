extends Node2D
class_name WorldBase

# used to determine current level
export(int) var world_num

func _ready():
	var world = Global.furthest_incomplete_level.world
	if world > world_num:
		load_all_levels()
	elif world == world_num:
		load_level(Global.furthest_incomplete_level.level-1)

func load_level(lvl):
	pass

func load_all_levels():
	pass
