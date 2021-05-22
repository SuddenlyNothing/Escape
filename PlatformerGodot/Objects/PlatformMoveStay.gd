tool
extends PlatformMove

func _ready():
	hide()

func start():
	show()
	tween_one_way()
	t.start()

func _process(delta):
	if Engine.editor_hint:
		show()
