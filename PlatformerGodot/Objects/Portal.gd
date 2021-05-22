extends Node2D
class_name Portal

export(String, FILE, "*.tscn") var next_scene

func _on_Area2D_body_entered(body):
	goto_next_scene()

func goto_next_scene():
	Global.goto_scene(next_scene)
