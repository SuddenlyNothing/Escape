extends ForkliftBase

func _physics_process(delta):
	if is_on_wall():
		flip()
	move()
