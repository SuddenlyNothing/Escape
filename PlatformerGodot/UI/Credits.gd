extends Control

export(String, FILE, "*.tscn") var menu

func _on_Menu_pressed():
	Global.goto_scene(menu)
