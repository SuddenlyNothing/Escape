extends Control

export(String, FILE, "*.tscn") var play
export(String, FILE, "*.tscn") var credits

func _on_Play_pressed():
	if play == "":
		return
	Global.goto_scene(play)

func _on_Credits_pressed():
	Global.goto_scene(credits)
