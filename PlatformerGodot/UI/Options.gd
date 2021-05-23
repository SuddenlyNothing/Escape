extends Control

var active := false

func _ready():
	hide()

func enter():
	show()
	get_tree().paused = true
	yield(get_tree(), "idle_frame")
	active = true

func exit():
	active = false
	hide()
	get_tree().paused = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and active:
		exit()

func _on_Back_pressed():
	exit()
