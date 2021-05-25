extends Control

onready var worlds := $VBoxContainer/Worlds

export(String, FILE, "*.tscn") var world1_scene
export(String, FILE, "*.tscn") var world2_scene

func _ready():
	for world in worlds.get_children():
		world.hide()
	load_worlds(Global.furthest_incomplete_level.world)

func load_worlds(world):
	if world < 1:
		return
	if world == 9001:
		for child in worlds.get_children():
			child.show()
		return
	worlds.get_child(world-1).show()
	load_worlds(world-1)

func _on_World1_pressed():
	Global.goto_scene(world1_scene)

func _on_World2_pressed():
	Global.goto_scene(world2_scene)
