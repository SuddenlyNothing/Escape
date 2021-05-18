extends "res://StateMachine.gd"

func _ready():
	add_state("idle")
	add_state("jump")
	add_state("fall")
	add_state("run")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	parent.apply_gravity()
	match state:
		states.idle:
			pass
		states.jump:
			parent.x_move_air()
		states.fall:
			parent.x_move_air()
		states.run:
			parent.x_move_ground()

func _get_transition(delta):
	match state:
		states.idle:
			if Input.is_action_pressed("move_left"):
				return states.run
			if Input.is_action_pressed("move_right"):
				return states.run
			if Input.is_action_pressed("jump"):
				return states.jump
		states.jump:
			if parent.y_vel > 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idle
		states.run:
			if parent.x_vel == 0:
				return states.idle
	return null

func _enter_state(new_state, old_state):
	match state:
		states.idle:
			parent.play_anim("idle")
		states.jump:
			parent.play_anim("jump")
			parent.jump()
		states.fall:
			parent.play_anim("fall")
		states.run:
			parent.play_anim("run")

func _exit_state(old_state, new_state):
	match state:
		states.idle:
			pass
		states.jump:
			pass
		states.fall:
			pass
		states.run:
			pass








