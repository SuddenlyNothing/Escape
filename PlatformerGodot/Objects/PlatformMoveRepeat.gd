tool
extends PlatformMove


func _process(_delta):
	if Engine.editor_hint:
		offset_end_point()
		show_platform_end()

func _ready():
	if !Engine.editor_hint:
		t.repeat = true
		tween_two_way()
		t.start()
		end_platform.hide()
