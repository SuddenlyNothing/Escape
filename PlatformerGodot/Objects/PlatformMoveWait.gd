tool
extends PlatformMove

func _process(_delta):
	if Engine.editor_hint:
		offset_end_point()
		show_platform_end()

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	print("Enter")
	t.repeat = true
	if !t.is_active():
		tween_two_way()
	t.start()

func _on_Area2D_body_exited(body):
	if body.name != "Player":
		return
	print("Exit")
	t.repeat = false
