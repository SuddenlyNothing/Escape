tool
extends Node2D

export(String, FILE, "*.png") var death_transition
export(String) var death_message := "Spiked"
export(int, "UP", "RIGHT", "DOWN", "LEFT") var dir := 0

func _process(delta):
	if Engine.editor_hint:
		match dir:
			0:
				rotation_degrees = 0
			1:
				rotation_degrees = 90
			2:
				rotation_degrees = 180
			3:
				rotation_degrees = 270

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	Global.restart(death_transition, death_message)
