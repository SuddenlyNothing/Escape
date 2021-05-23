extends Node2D

onready var player := $Player

func _ready():
	if Global.level_checkpoint != null:
		player.position = Global.level_checkpoint
