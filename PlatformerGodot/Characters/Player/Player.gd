extends KinematicBody2D

onready var sprite := $DirectionDependents/Sprite
onready var state_label := $StateLabel
onready var direction_dependents := $DirectionDependents
onready var horizontal_raycast := $DirectionDependents/RayCast2D
onready var coyote_timer := $CoyoteTimer
onready var state_machine := $StateMachine

export(float) var air_move_speed := 20.0
export(float) var ground_move_speed := 50.0
export(float) var max_x_move_speed := 300.0

export(float) var friction := 30.0
export(float) var air_friction := 20.0

export(float) var jump_force := 600.0

export(float) var gravity := 25.0
export(float) var max_fall_speed := 1000.0

var x_vel := 0.0
var facing_right := true

var snap_default := Vector2.DOWN * 32

var y_vel := 0.0
var max_y := 20000

func _ready():
	Global.player = self

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

func apply_air_friction():
	if x_vel > air_friction:
		x_vel -= air_friction
	elif x_vel < -air_friction:
		x_vel += air_friction
	else:
		x_vel = 0

func jump():
	y_vel = -jump_force

func x_move_ground():
#	x_move_input(ground_move_speed)
	var x_input_val = x_input()
	
	if x_input_val == 0:
		apply_friction()
		return
	
	if x_input_val < 0 and facing_right:
		x_vel = 0
	if x_input_val > 0 and !facing_right:
		x_vel = 0
	
	x_vel = clamp(x_vel+ground_move_speed*x_input_val, -max_x_move_speed, max_x_move_speed)

func x_move_air():
	x_move_input(air_move_speed)

func x_move_input(speed):
	if is_horizontal_colliding():
		x_vel = 0
	
	var x_input_val = x_input()
	x_vel += speed*x_input_val
	
	if x_input_val == 0:
		if is_on_floor():
			apply_friction()
		else:
			apply_air_friction()
	
	x_vel = clamp(x_vel, -max_x_move_speed, max_x_move_speed)

func x_input():
	var x_input_val = 0
	if Input.is_action_pressed("move_left"):
		x_input_val -= 1
	if Input.is_action_pressed("move_right"):
		x_input_val += 1
	return x_input_val

func move(snap):
	var _collision = move_and_slide_with_snap(Vector2(x_vel, y_vel), snap, Vector2(0, -1))

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

func get_state():
	return state_machine.state

func check_death_y():
	if position.y > max_y:
		Global.restart()
