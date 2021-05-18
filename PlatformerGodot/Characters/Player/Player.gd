extends KinematicBody2D

onready var sprite := $Sprite

export(int) var health := 5

export(int) var air_move_speed := 20
export(int) var ground_move_speed := 50
export(int) var max_x_move_speed := 1000

export(int) var friction := 20

export(int) var jump_force := 1000

export(int) var gravity := 100
export(int) var max_fall_speed := 1000

var x_vel := 0

var y_vel := 0

func apply_gravity():
	if is_on_floor():
		y_vel = gravity
		return
	y_vel = clamp(y_vel+gravity, -jump_force, max_fall_speed)

func apply_friction():
	if x_vel > friction:
		x_vel -= friction
	elif x_vel < friction:
		x_vel += friction
	else:
		x_vel = 0

func jump():
	y_vel = -jump_force

func x_movement_ground():
	x_movement_input(ground_move_speed)

func x_movement_air():
	x_movement_input(air_move_speed)

func x_movement_input(speed):
	if Input.is_action_pressed("move_left"):
		x_vel -= speed
	if Input.is_action_pressed("move_right"):
		x_vel += speed
	x_vel = clamp(x_vel, -max_x_move_speed, max_x_move_speed)

func move():
	move_and_slide(Vector2(x_vel, y_vel), Vector2(0, 1))










