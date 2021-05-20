extends KinematicBody2D

onready var animated_sprite := $AnimatedSprite

var gravity := 25.0

var y_vel := 0
var max_fall_speed := 1000

var moving := false

var x_speed := 200
var friction := 15

func move():
	if moving:
		move_and_slide(Vector2(x_speed, y_vel), Vector2.UP)
	else:
		move_and_slide(Vector2(0, y_vel), Vector2.UP)

func apply_force(dir):
	animated_sprite.play()
	moving = true
	

func flip():
	animated_sprite.scale.x *= -1
	x_speed *= -1

func apply_gravity():
	if is_on_floor():
		y_vel = clamp(y_vel+gravity, 0, gravity)
		return
	y_vel = clamp(y_vel+gravity, 0, max_fall_speed)

func _physics_process(delta):
	if is_on_wall():
		flip()
	apply_gravity()
	move()
