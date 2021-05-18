extends KinematicBody2D

onready var sprite := $Sprite
onready var state_label := $StateLabel

export(int) var health := 5

export(int) var air_move_speed := 20
export(int) var ground_move_speed := 50
export(int) var max_x_move_speed := 500

export(int) var friction := 40

export(int) var jump_force := 1000

export(int) var gravity := 100
export(int) var max_fall_speed := 1000

var x_vel := 0

var y_vel := 0

func apply_gravity():
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
	if Input.is_action_pressed("move_left"):
		x_vel -= speed
	if Input.is_action_pressed("move_right"):
		x_vel += speed
	x_vel = clamp(x_vel, -max_x_move_speed, max_x_move_speed)

func move():
	move_and_slide(Vector2(x_vel, y_vel), Vector2(0, -1))

func play_anim(anim):
	sprite.play(anim)








