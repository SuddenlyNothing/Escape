extends StaticCamera

onready var tween := $Tween

export(float) var rotation_speed := 30.0
export(int) var rotation_start := 45
export(int) var rotation_end := 135

func _ready():
	init_tween()

func init_tween():
	var duration = abs(rotation_end-rotation_start)/rotation_speed
	tween.interpolate_property(rotation_dependents, "rotation_degrees", rotation_start, rotation_end, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(rotation_dependents, "rotation_degrees", rotation_end, rotation_start, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT, duration)
	tween.start()
