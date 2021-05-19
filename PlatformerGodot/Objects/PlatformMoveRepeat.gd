extends "res://Objects/PlatformMove.gd"

func _ready():
	t.repeat = true
	init_tween()
	t.start()
