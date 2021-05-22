extends AnimatedSprite

onready var footstep_sfx := $Footstep

func _on_Sprite_frame_changed():
	if animation == "run":
		if frame == 1 or frame == 4:
			footstep_sfx.play()
