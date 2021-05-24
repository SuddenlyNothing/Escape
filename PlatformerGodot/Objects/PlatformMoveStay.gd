tool
extends PlatformMove

onready var collision := platform.get_node("CollisionShape2D")

func _ready():
	hide()
	collision.call_deferred("set_disabled", true)

func start():
	show()
	tween_one_way()
	t.start()
	collision.call_deferred("set_disabled", false)

func _process(delta):
	if Engine.editor_hint:
		show()
