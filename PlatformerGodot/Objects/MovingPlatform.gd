extends Line2D

onready var platform := $Platform
onready var t := $Tween

export(int) var speed := 100

func _ready():
	init_tween()

func init_tween():
	var end_point := get_point_position(1)
	var duration = platform.position.distance_to(end_point)/speed
	t.interpolate_property(platform, "position", platform.position, end_point, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	t.interpolate_property(platform, "position", end_point, platform.position, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT, duration)
	t.start()
