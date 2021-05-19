extends VisibilityNotifier2D

var parent = null setget set_parent

var screen_entered = false

func set_parent(val):
	parent = val
	if screen_entered:
		return
	set_processes(false)

func _on_VisibilityNotifier2D_screen_entered():
	if screen_entered:
		return
	screen_entered = true
	if parent != null:
		set_processes(true)

func set_processes(val):
	parent.set_process(val)
	parent.set_physics_process(val)
