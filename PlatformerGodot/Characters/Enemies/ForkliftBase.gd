extends KinematicBody2D
class_name ForkliftBase

export(float) var speed := 100.0
export(String, FILE, "*.png") var death_transition
export(String) var death_message := "You Were Caught"

export(bool) var unload_until_offscreen := true

onready var v_n := $VisibilityNotifier2D
onready var flip := $Flip

var x_dir := -1.0
var y_vel := 0
var snap_default := Vector2.DOWN * 31.0
var gravity := 25.0
var max_fall_speed := 1000.0

func _ready():
	if unload_until_offscreen:
		v_n.set_parent(self)

func flip():
	x_dir *= -1
	flip.scale.x *= -1

func apply_gravity():
	if is_on_floor():
		y_vel = clamp(y_vel+gravity, 0, gravity)
		return
	y_vel = clamp(y_vel+gravity, 0, max_fall_speed)

func move():
	var snap = snap_default
	if !is_on_floor():
		snap = Vector2.ZERO
	apply_gravity()
	var collision = move_and_slide_with_snap(Vector2(x_dir*speed, y_vel), snap, Vector2.UP)

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	Global.restart(death_transition, death_message)

