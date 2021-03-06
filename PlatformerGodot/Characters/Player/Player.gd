extends KinematicBody2D

signal grounded_updated(is_grounded)

onready var sprite := $DirectionDependents/Sprite
onready var state_label := $StateLabel
onready var direction_dependents := $DirectionDependents
onready var horizontal_raycast := $DirectionDependents/RayCast2D
onready var coyote_timer := $CoyoteTimer
onready var state_machine := $StateMachine
onready var player_body_collision := $PlayerBodyCollision
onready var jump_buffer := $JumpBuffer

export(float) var air_move_speed := 20.0
export(float) var ground_move_speed := 50.0
export(float) var max_x_move_speed := 300.0

export(float) var friction := 30.0
export(float) var air_friction := 10.0

export(float) var jump_force := 600.0

export(float) var gravity := 25.0
export(float) var max_fall_speed := 1000.0

export(String, FILE, "*.png") var death_fall_transition
export(String) var death_fall_message := "You Fell"

var last_floor_contact_pos := position

var x_vel := 0.0
var facing_right := true

var snap_default := Vector2.DOWN * 31

var y_vel := 0.0
var max_y := 200 # 200

var floor_vel := Vector2.ZERO

func _ready():
	Global.player = self

func apply_gravity():
	if is_on_floor():
		if y_vel < -jump_force:
			return
		if y_vel > gravity:
			y_vel = gravity
	if y_vel > max_fall_speed:
		return
	y_vel += gravity

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
	var x_input_val = x_input()
	
	if x_input_val == 0 or abs(x_vel) > max_x_move_speed:
		apply_friction()
		return
	
	if x_input_val < 0 and facing_right:
		x_vel = 0
	if x_input_val > 0 and !facing_right:
		x_vel = 0
	
	if abs(x_vel) > max_x_move_speed:
		return
	x_vel += ground_move_speed*x_input_val

func x_move_air():
	x_move_input(air_move_speed)

func x_move_input(speed):
	if is_horizontal_colliding():
		x_vel = 0
	
	var x_input_val = x_input()
	if x_input_val > 0:
		if x_vel < max_x_move_speed:
			x_vel += speed * x_input_val
	else:
		if x_vel > -max_x_move_speed:
			x_vel += speed * x_input_val
	
	if x_input_val == 0 or abs(x_vel) > max_x_move_speed:
		if is_on_floor():
			apply_friction()
		else:
			apply_air_friction()

func x_input():
	var x_input_val = 0
	if Input.is_action_pressed("move_left"):
		x_input_val -= 1
	if Input.is_action_pressed("move_right"):
		x_input_val += 1
	return x_input_val

func move(snap):
	var _velocity = move_and_slide_with_snap(Vector2(x_vel, y_vel), snap, Vector2(0, -1),
		false, 4, PI/4, false)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("pushables"):
			if collision.normal.x != 0:
				collision.collider.apply_force(-collision.normal.x)

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
		Global.restart(death_fall_transition, death_fall_message)

func set_idle_body():
	player_body_collision.shape.set_extents(Vector2(8, 8))
	player_body_collision.position = Vector2(0, 8)

func set_body():
	player_body_collision.shape.set_extents(Vector2(8, 12.5))
	player_body_collision.position = Vector2(0, 3.5)

func get_body_corners():
	var body_shape = player_body_collision.get_shape()
	var body_extents = body_shape.extents
	var body_offset = player_body_collision.position
	var corners = PoolVector2Array()
	corners.append(position+body_offset+body_extents)
	corners.append(position+body_offset-body_extents)
	corners.append(position+body_offset+Vector2(body_extents.x, -body_extents.y))
	corners.append(position+body_offset+Vector2(-body_extents.x, body_extents.y))
	corners.append(position+body_offset)
	return corners

func start_jump_buffer():
	if Input.is_action_just_pressed("jump"):
		jump_buffer.start()

func is_jump_buffer_active():
	return !jump_buffer.is_stopped()

func store_floor_velocity():
	if is_on_floor():
		floor_vel = get_floor_velocity()

func apply_floor_velocity():
	print(floor_vel)
	x_vel += floor_vel.x
	y_vel += floor_vel.y

func stop_momentum():
	x_vel = clamp(x_vel, -max_x_move_speed, max_x_move_speed)
	y_vel = gravity
