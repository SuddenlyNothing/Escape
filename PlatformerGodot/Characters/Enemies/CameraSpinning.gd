tool
extends CameraStatic

export(int) var rot_speed := 50

func _process(delta):
	if !Engine.editor_hint:
		rotation_dependents.rotation_degrees += rot_speed *delta
