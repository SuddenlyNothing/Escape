tool
extends CameraStatic

onready var tween := $Tween

export(float) var rotation_speed := 30.0
export(int) var rotation_end := 135

func _ready():
	init_tween()
	$HintLight.enabled = false

func init_tween():
	var duration = abs(rotation_end-rot_deg)/rotation_speed
	tween.interpolate_property(rotation_dependents, "rotation_degrees", rot_deg, rotation_end, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.interpolate_property(rotation_dependents, "rotation_degrees", rotation_end, rot_deg, duration,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT, duration)
	tween.start()

func _process(delta):
	if Engine.editor_hint:
		$HintLight.enabled = true
		set_rot_deg()
		$HintLight.rotation_degrees = rotation_end
