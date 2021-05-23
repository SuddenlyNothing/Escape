extends Portal

func goto_next_scene():
	Global.finish_current_level()
	Global.goto_scene(next_scene)
