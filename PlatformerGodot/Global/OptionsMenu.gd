extends Button

func disable_options_menu():
	disabled = true
	hide()

func enable_options_menu():
	disabled = false
	show()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		print(get_tree().paused)
		Global.options_menu_enter()

func _on_OptionsMenu_pressed():
	Global.options_menu_enter()
