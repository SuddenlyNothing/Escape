tool
extends PlatformMove

onready var player_detection := $PlayerDetection

var player = null

func _process(delta):
	if Engine.editor_hint:
		offset_end_point()
		show_platform_end()
	else:
		if player == null and Global.player != null:
			player = Global.player
		if is_player_on_platform():
			if !t.is_active():
				tween_two_way()
				t.start()

func is_player_on_platform():
	if player == null:
		return
	if player_detection.overlaps_body(player):
		return true
	return false
