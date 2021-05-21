tool
extends StaticBody2D

export(int) var conveyor_speed := 50
export(int) var facing_right := false

func _process(_delta):
	if Engine.editor_hint:
		if facing_right:
			scale.x = -1
			constant_linear_velocity = Vector2.RIGHT*conveyor_speed
		else:
			scale.x = 1
			constant_linear_velocity = Vector2.LEFT*conveyor_speed
