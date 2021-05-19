extends Line2D

onready var platform := $Platform
onready var t := $Tween

export(int) var speed := 100
export(float) var idle_seconds := 0.2

func tween_two_way():
	var start_point := get_point_position(0)
	var end_point := get_point_position(1)
	var duration = platform.position.distance_to(end_point)/speed
	t.interpolate_property(platform, "position", start_point, end_point, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	t.interpolate_property(platform, "position", end_point, start_point, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT, duration+idle_seconds)

func tween_one_way():
	var start_point := get_point_position(0)
	var end_point := get_point_position(1)
	var duration = platform.position.distance_to(end_point)/speed
	t.interpolate_property(platform, "position", start_point, end_point, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
