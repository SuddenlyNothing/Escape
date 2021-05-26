extends Node2D
class_name WorldBase

onready var player := $Player

# used to determine current level
export(int) var world_num

func _ready():
	assert(world_num!=0, "Error: world_num can't be 0. The current world_num is "+str(world_num))
	Global.current_world = world_num
	Global.in_world = true
	var fil = Global.furthest_incomplete_level
	if fil.world > world_num:
		load_all_levels()
	elif fil.world == world_num:
		load_level(fil.level-1)
	if Global.world_checkpoint.world == world_num:
		player.position = Global.world_checkpoint.player_pos

func load_level(lvl):
	pass

func load_all_levels():
	pass

func _on_WorldBase_tree_exiting():
	Global.in_world = false
