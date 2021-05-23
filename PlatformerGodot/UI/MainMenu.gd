extends Control

export(String, FILE, "*.tscn") var intro_cutscene
export(String, FILE, "*.tscn") var play
export(String, FILE, "*.tscn") var credits
export(String, FILE, "*.tscn") var tutorial

func _on_Play_pressed():
	if play == "":
		return
	if Global.did_intro_cutscene:
		Global.goto_scene(play)
	else:
		Global.goto_scene(intro_cutscene)

func _on_Credits_pressed():
	Global.goto_scene(credits)

func _on_Tutorial_pressed():
	Global.goto_scene(tutorial)
