extends Node2D
class_name Checkpoint

onready var checkpoint_lit_sprite := $CheckpointLit
onready var light := $Light2D
onready var save_position = $SavePosition.position

func save_checkpoint():
	pass

func light_up():
	checkpoint_lit_sprite.show()
	light.enabled = true

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	light_up()
	save_checkpoint()
