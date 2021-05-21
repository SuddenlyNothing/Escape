extends Node2D

export(String, FILE, "*.png") var death_transition
export(String) var death_message := "Spiked"



func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return
	Global.restart(death_transition, death_message)
