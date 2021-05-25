extends Control

export(String, FILE, "*.tscn") var credits_scene

func _on_Credits_pressed():
	Global.goto_scene(credits_scene)
