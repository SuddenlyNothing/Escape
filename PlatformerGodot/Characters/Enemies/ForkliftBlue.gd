extends ForkliftBase

onready var detect_platform := $DetectPlatform

var num_bodies_in_detection := 0

func _physics_process(delta):
	if is_on_wall():
		flip()
	move()

func _on_DetectPlatform_body_exited(body):
	if body.name == "player":
		return
	num_bodies_in_detection -= 1
	if num_bodies_in_detection == 0:
		flip()

func _on_DetectPlatform_body_entered(body):
	num_bodies_in_detection += 1
