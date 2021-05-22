extends Control

onready var label = $Control/RichTextLabel
onready var tween = $Control/Tween
onready var next_sfx = $NextDialog
onready var marker = $Marker

export(PoolStringArray) var dialog = ["YOU FORGOT TO SET THE DIALOG STRING!!!"]

var dialog_index = 0
var finished = false
var started = false

signal dialogue_finished

func start():
	started = true
	visible = true
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
		tween.interpolate_property(label, "percent_visible", 0, 1, len(dialog[dialog_index])/25)
		tween.start()
	else:
		next_sfx.play()
		yield(next_sfx, "finished")
		emit_signal("dialogue_finished")
		queue_free()
	dialog_index += 1

func _on_Tween_tween_all_completed():
	finished = true
	marker.visible = true
