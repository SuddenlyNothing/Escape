tool
extends Line2D
class_name PlatformMove

onready var platform := $Platform
onready var t := $Tween
onready var end_platform := $EndPlatform

export(int) var speed := 100
export(float) var idle_seconds := 0.2

var platform_offset := Vector2(0, -4)

func show_platform_end():
	$EndPlatform.show()
	$EndPlatform.position = get_point_position(1)

func offset_end_point():
	var end_point = get_point_position(1)
	if int(end_point.y) % 8 == 0:
		end_point.y += 4
	set_point_position(1, end_point)

func _ready():
	if !Engine.editor_hint:
		end_platform.hide()

func _process(_delta):
	if Engine.editor_hint:
		offset_end_point()
		show_platform_end()

func tween_two_way():
	var start_point := get_point_position(0)
	var end_point := get_point_position(1)
	var duration = platform.position.distance_to(end_point)/speed
	t.interpolate_property(platform, "position", start_point+platform_offset, end_point+platform_offset, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	t.interpolate_property(platform, "position", end_point+platform_offset, start_point+platform_offset, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT, duration+idle_seconds)

func tween_one_way():
	var start_point := get_point_position(0)
	var end_point := get_point_position(1)
	var duration = platform.position.distance_to(end_point)/speed
	t.interpolate_property(platform, "position", start_point+platform_offset, end_point+platform_offset, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
