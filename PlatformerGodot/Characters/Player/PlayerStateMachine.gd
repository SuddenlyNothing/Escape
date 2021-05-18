extends "res://StateMachine.gd"

func _ready():
	add_state("idle")
	add_state("jump")
	add_state("fall")
	add_state("run")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	parent.state_label.text = str(state)
	parent.apply_gravity()
	parent.move()
	match state:
		states.idle:
			pass
		states.jump:
			parent.x_move_air()
		states.fall:
			parent.x_move_air()
		states.run:
			parent.set_facing_right()
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
			if parent.is_on_ceiling():
				return states.fall
		states.fall:
			if !parent.coyote_timer.is_stopped():
				if Input.is_action_pressed("jump") and previous_state != states.jump:
					return states.jump
			if parent.is_on_floor():
				if parent.x_vel == 0:
					return states.idle
				else:
					return states.run
		states.run:
			if !parent.is_on_floor():
				return states.fall
			if parent.x_vel == 0:
				return states.idle
			if Input.is_action_pressed("jump"):
				return states.jump
	return null

func _enter_state(new_state, old_state):
	match state:
		states.idle:
			parent.play_anim("idle")
		states.jump:
			parent.play_anim("jump")
			parent.jump()
		states.fall:
			if parent.y_vel < 0:
				parent.y_vel = 0
			parent.play_anim("fall")
			parent.coyote_timer.start()
		states.run:
			parent.play_anim("run")

func _exit_state(old_state, new_state):
	match state:
		states.idle:
			pass
		states.jump:
			pass
		states.fall:
			parent.coyote_timer.stop()
		states.run:
			pass








