extends HSlider

export(String, "Master", "SFX", "Music") var audio_bus_name := "Master"

onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func _ready() -> void:
	yield(Global, "ready")
	print(name+" ready")
	value = db2linear(AudioServer.get_bus_volume_db(_bus))

func _on_VolumeSlider_value_changed(value):
	Global.set_volume(audio_bus_name, value)
