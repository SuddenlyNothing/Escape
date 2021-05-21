extends ColorRect

signal faded_in

onready var t := $Tween

func fade_in():
	t.interpolate_property(self, "modulate:a", 1, 0, 0.5)
	t.start()
	yield(t, "tween_all_completed")
	emit_signal("faded_in")
