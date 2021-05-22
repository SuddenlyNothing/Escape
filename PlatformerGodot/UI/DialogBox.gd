extends Control

onready var label = $Control/Label
onready var tween = $Tween
onready var next_sfx = $NextDialog
onready var marker = $Control/Marker

export(PoolStringArray) var dialog = ["YOU FORGOT TO SET THE DIALOG STRING!!!"]

var dialog_index = 0
var finished = false
var started = false

signal dialog_finished

func start():
	next_sfx.play()
	started = true
	show()
	load_dialog()

func _process(delta):
	if !started:
		return
	if Input.is_action_just_pressed("next_dialog"):
		if finished:
			load_dialog()
			next_sfx.play()
		else:
			tween.stop_all()
			label.percent_visible = 1
			marker.visible = true
			finished = true

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		marker.visible = false
		label.bbcode_text = dialog[dialog_index]
		label.percent_visible = 0
		tween.interpolate_property(label, "percent_visible", 0, 1, len(dialog[dialog_index])/25.0)
		tween.start()
		print("tween started")
	else:
		next_sfx.play()
		yield(next_sfx, "finished")
		emit_signal("dialog_finished")
		queue_free()
	dialog_index += 1

func _on_Tween_tween_all_completed():
	finished = true
	marker.visible = true
