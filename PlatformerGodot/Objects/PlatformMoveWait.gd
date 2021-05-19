extends "res://Objects/PlatformMove.gd"

var started = false

func _ready():
	init_tween()

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	if started:
		return
	started = true
	t.start()
