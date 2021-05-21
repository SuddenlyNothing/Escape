tool
extends CameraBase
class_name CameraStatic

func _process(delta):
	if !Engine.editor_hint:
		if player == null:
			player = Global.player
		if is_player_in_vision():
			found_player()
