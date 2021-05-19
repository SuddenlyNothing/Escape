extends "res://Characters/Enemies/BaseForklift.gd"

func _physics_process(delta):
	if is_on_wall():
		flip()
	move()

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	Global.restart()
