extends Control

onready var levels_button := $VBoxContainer/HBoxContainer/Levels
onready var worlds_button := $VBoxContainer/HBoxContainer/Worlds

export(String, FILE, "*.tscn") var worlds_scene

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
	
	if Global.current_level.level > -1:
		levels_button.show()
	else:
		levels_button.hide()
	
	if Global.furthest_incomplete_level.world > 1:
		worlds_button.show()
	else:
		worlds_button.hide()

func _on_Back_pressed():
	exit()

func _on_Levels_pressed():
	Global.goto_previous_scene()

func _on_Worlds_pressed():
	Global.goto_scene(worlds_scene)
