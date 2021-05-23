extends Node2D
class_name Portal

export(String, FILE, "*.tscn") var next_scene

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	goto_next_scene()

func goto_next_scene():
	Global.goto_scene(next_scene)
