extends Node2D

export(String, FILE, "*.tscn") var world_select
export(String, FILE, "*.tscn") var world_1
export(String, FILE, "*.tscn") var world_2

onready var anim_player := $AnimationPlayer

onready var leader := $ForkliftBase
onready var goon1 := $ForkliftBase2
onready var goon2 := $ForkliftBase3

onready var leader_sprite := $ForkliftBase/Flip/AnimatedSprite
onready var goon1_sprite := $ForkliftBase2/Flip/AnimatedSprite
onready var goon2_sprite := $ForkliftBase3/Flip/AnimatedSprite

onready var dialog_box := $CanvasLayer/DialogBox

onready var timer := $Timer

var forklift_start_moving = false

func _ready():
	Global.start_level_music()
	anim_player.play("PlayerHide")
	yield(anim_player, "animation_finished")
	flip()
	forklift_start_moving = true

func _process(_delta):
	if forklift_start_moving:
		move()

func flip():
	leader.flip()
	goon1.flip()
	goon2.flip()

func move():
	leader.move()
	goon1.move()
	goon2.move()

func sprite_play(val):
	leader_sprite.playing = val
	goon1_sprite.playing = val
	goon2_sprite.playing = val

func _on_Area2D_body_entered(_body):
	if forklift_start_moving:
		forklift_start_moving = false
		sprite_play(false)
		leader.flip()
		for forklift in get_tree().get_nodes_in_group("forklifts"):
			forklift.get_node("DriveLoop").stop()
		print("yo")
		dialog_box.start()
		yield(dialog_box, "dialog_finished")
		print("yo")
		goon1.flip()
		goon2.flip()
		for forklift in get_tree().get_nodes_in_group("forklifts"):
			forklift.get_node("DriveLoop").play()
		sprite_play(true)
		forklift_start_moving = true
		timer.start()

func _on_Timer_timeout():
	anim_player.play("PlayerEscape")
	yield(anim_player, "animation_finished")
	goto_world()

func goto_world():
	Global.complete_intro_cutscene()
	if Global.furthest_incomplete_level.world == 1:
		Global.goto_scene(world_1)
	elif  Global.furthest_incomplete_level.world == 2:
		Global.goto_scene(world_2)
	else:
		Global.goto_scene(world_select)

func _on_Skip_pressed():
	goto_world()
