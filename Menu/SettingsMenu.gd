extends Control
@onready var master = $HBoxContainer/Slider/Master
@onready var music = $HBoxContainer/Slider/Music
@onready var sound_fx = $"HBoxContainer/Slider/Sound FX"


func _ready():
	master.value = db_2_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	music.value = db_2_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Background")))
	sound_fx.value = db_2_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Vfx")))

func _on_back_from_audio_pressed():
	Global.game.unload_menu()
	Global.game.load_menu("MainMenu")




func adjust_volume(bus_name: String, linear_value: float):
	var db_value = linear_2db(linear_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), db_value)
	

func db_2_linear(db_value: float) -> float:
	if db_value <= -80.0:
		return 0.0
	else:
		return 100.0 * pow(10.0, db_value / 20.0)

func linear_2db(linear_value: float) -> float:
	if linear_value == 0:
		return -80.0
	else:
		var t = linear_value / 100.0
		return 20.0 * log(t) / log(10.0)






func _on_music_value_changed(value):
	print(value)
	adjust_volume("Background", value)


func _on_master_value_changed(value):
	adjust_volume("Master", value)


func _on_sound_fx_value_changed(value):
	adjust_volume("Vfx", value)
