extends Node2D

export(PackedScene) var next_scene

func _on_Area2D_body_entered(body):
	Global.goto_scene(next_scene)
