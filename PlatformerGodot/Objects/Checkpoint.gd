extends Node2D
class_name Checkpoint

onready var checkpoint_lit_sprite := $CheckpointLit
onready var light := $Light2D
onready var save_position = $SavePosition.global_position
onready var t := $Tween

var lit := false

func save_checkpoint():
	pass

func light_up():
	if !lit:
		checkpoint_lit_sprite.show()
		t.interpolate_property(light, "energy", 0, 0.5, 0.5)
		t.start()
		lit = true

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	light_up()
	save_checkpoint()
