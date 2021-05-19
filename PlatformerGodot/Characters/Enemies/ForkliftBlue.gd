extends "res://Characters/Enemies/BaseForklift.gd"

func _on_Area2D2_body_exited(body):
	if body.name == "Player":
		return
	flip()

func _physics_process(delta):
	if is_on_wall():
		flip()
	move()
