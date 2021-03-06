extends StateMachine

func _ready():
	add_state("idle")
	add_state("jump")
	add_state("fall")
	add_state("run")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	parent.check_death_y()
	parent.apply_gravity()
	parent.state_label.text = str(state) +" "+var2str(Vector2(parent.x_vel, parent.y_vel))+"\n"+"is_on_floor "+str(parent.is_on_floor())
	var snap = parent.snap_default
	match state:
		states.idle:
			parent.store_floor_velocity()
		states.jump:
			parent.x_move_air()
			snap = Vector2.ZERO
		states.fall:
			snap = Vector2.ZERO
			parent.x_move_air()
			parent.start_jump_buffer()
		states.run:
			parent.store_floor_velocity()
			parent.set_facing_right()
			parent.x_move_ground()
	parent.move(snap)

func _get_transition(delta):
	match state:
		states.idle:
			if parent.x_input() != 0:
				return states.run
			if Input.is_action_pressed("jump"):
				return states.jump
			if !parent.is_on_floor():
				return states.fall
			if parent.is_jump_buffer_active():
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
			if parent.is_jump_buffer_active():
				return states.jump
	return null

func _enter_state(new_state, old_state):
	match state:
		states.idle:
			parent.stop_momentum()
			if previous_state == states.jump or previous_state == states.fall:
				parent.emit_signal("grounded_updated", true)
			parent.set_idle_body()
			parent.play_anim("idle")
		states.jump:
			if previous_state == states.idle or previous_state == states.run:
				parent.emit_signal("grounded_updated", false)
			parent.play_anim("jump")
			parent.jump()
			parent.apply_floor_velocity()
		states.fall:
			if previous_state != states.jump:
				parent.apply_floor_velocity()
			if previous_state == states.idle or previous_state == states.run:
				parent.emit_signal("grounded_updated", false)
			if parent.y_vel < 0:
				parent.y_vel = 0
			parent.play_anim("fall")
			parent.coyote_timer.start()
		states.run:
			parent.stop_momentum()
			if previous_state == states.jump or previous_state == states.fall:
				parent.emit_signal("grounded_updated", true)
			parent.play_anim("run")

func _exit_state(old_state, new_state):
	match old_state:
		states.idle:
			parent.set_body()
		states.jump:
			pass
		states.fall:
			parent.coyote_timer.stop()
		states.run:
			pass






