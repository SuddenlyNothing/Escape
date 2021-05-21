extends ColorRect

signal faded_out

onready var t := $Tween
onready var transition := $Transition
onready var trans_message := $Message

func fade_out(texture = null, message = ""):
	trans_message.text = message
	if texture == "" or texture == null:
		transition.set_texture(null)
	else:
		var transition_texture = load(texture)
		transition.set_texture(transition_texture)
	t.interpolate_property(self, "modulate:a", 0, 1, 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	t.start()
	yield(t, "tween_all_completed")
	emit_signal("faded_out")

func fade_out_hide():
	yield(get_tree(), "idle_frame")
	modulate.a = 0
