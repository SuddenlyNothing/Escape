extends "res://Characters/Enemies/BaseForklift.gd"

func _physics_process(delta):
	if is_on_wall():
		flip()
	move()
