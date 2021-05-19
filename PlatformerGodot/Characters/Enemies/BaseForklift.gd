extends KinematicBody2D

export(float) var speed := 100.0

var x_dir := 1.0
var y_vel := 0
var snap_default := 32.0
var gravity := 25.0
var max_fall_speed := 1000.0

func flip():
	x_dir *= -1
	scale.x *= -1

func apply_gravity():
	if is_on_floor():
		y_vel = clamp(y_vel+gravity, 0, gravity)
		return
	y_vel = clamp(y_vel+gravity, 0, max_fall_speed)

func _physics_process(delta):
	var snap = snap_default
	if !is_on_floor():
		snap = 0
	apply_gravity()
	move_and_slide_with_snap(Vector2(x_dir*speed, y_vel), snap, Vector2.UP)
