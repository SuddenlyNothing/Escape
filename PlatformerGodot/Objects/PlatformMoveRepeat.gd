extends "res://Objects/PlatformMove.gd"

func _ready():
	t.repeat = true
	tween_two_way()
	t.start()
