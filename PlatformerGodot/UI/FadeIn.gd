extends Control

onready var t := $Tween
onready var c_r := $ColorRect

func _ready():
	t.interpolate_property(c_r, "self_modulate:a", 1, 0, 0.5)
	t.start()
