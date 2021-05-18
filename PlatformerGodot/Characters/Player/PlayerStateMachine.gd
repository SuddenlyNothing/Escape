extends "res://StateMachine.gd"

func _ready():
	add_state("idle")
	add_state("jump")
	add_state("fall")
	add_state("run")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	match state:
		states.idle:
			pass
		states.jump:
			pass
		states.fall:
			pass
		states.run:
			pass

func _get_transition(dleta):
	match state:
		states.idle:
			pass
		states.jump:
			pass
		states.fall:
			pass
		states.run:
			pass
	return null

func _enter_state(new_state, old_state):
	match state:
		states.idle:
			pass
		states.jump:
			pass
		states.fall:
			pass
		states.run:
			pass

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








