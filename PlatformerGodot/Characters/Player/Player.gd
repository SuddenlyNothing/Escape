extends KinematicBody2D

onready var sprite := $DirectionDependents/Sprite
onready var state_label := $StateLabel
onready var direction_dependents := $DirectionDependents
onready var horizontal_raycast := $DirectionDependents/RayCast2D
onready var coyote_timer := $CoyoteTimer

export(int) var air_move_speed := 20.0
export(int) var ground_move_speed := 50.0
export(int) var max_x_move_speed := 500.0

export(int) var friction := 50.0

export(int) var jump_force := 600.0

export(int) var gravity := 25.0
export(int) var max_fall_speed := 1000.0

var x_vel := 0.0
var facing_right = true

var y_vel := 0.0

func apply_gravity():
	if is_on_floor():
		y_vel = clamp(y_vel+gravity, -jump_force, gravity)
		return
	y_vel = clamp(y_vel+gravity, -jump_force, max_fall_speed)

func apply_friction():
	if x_vel > friction:
		x_vel -= friction
	elif x_vel < -friction:
		x_vel += friction
	else:
		x_vel = 0

func jump():
	y_vel = -jump_force

func x_move_ground():
	x_move_input(ground_move_speed)

func x_move_air():
	x_move_input(air_move_speed)

func x_move_input(speed):
	if is_horizontal_colliding():
		x_vel = 0
	if Input.is_action_pressed("move_left"):
		x_vel -= speed
	if Input.is_action_pressed("move_right"):
		x_vel += speed
	if !(Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
		apply_friction()
	x_vel = clamp(x_vel, -max_x_move_speed, max_x_move_speed)

func move():
	move_and_slide(Vector2(x_vel, y_vel), Vector2(0, -1))

func play_anim(anim):
	sprite.play(anim)

func set_facing_right():
	if facing_right and x_vel < 0:
		facing_right = false
		direction_dependents.scale.x *= -1
	elif !facing_right and x_vel > 0:
		facing_right = true
		direction_dependents.scale.x *= -1

func is_horizontal_colliding():
	if horizontal_raycast.is_colliding() and is_on_wall():
		return true




