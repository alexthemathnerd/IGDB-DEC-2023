class_name WaveSpawner
extends Node2D

@export var spawn_area: NodePath
@export var target: NodePath
@export var spawn_radius: int = 500

@onready var wave: Wave = $Wave

signal game_completed

var _start = false
var current_wave_index = 0
var waves_data = []

func _ready():
	waves_data.append(preload("res://Wave/Wave1.tres"))
	waves_data.append(preload("res://Wave/Wave2.tres"))
	waves_data.append(preload("res://Wave/Wave3.tres"))
	wave.wave_completed.connect(_on_wave_completed)
	

func _process(delta):
	if not _start and current_wave_index < waves_data.size():
		var current_wave_data = waves_data[current_wave_index]
		wave.init(current_wave_data)
		wave.start()
		_start = true
	check_for_game_completion()

func _on_wave_completed():
	_start = false
	current_wave_index += 1
	if current_wave_index >= waves_data.size():
		print("ALL Waves Completed")
	else:
		await get_tree().create_timer(1.0).timeout

func check_for_game_completion():
	if wave.active_enemies.is_empty() and current_wave_index >= waves_data.size():
		game_completed.emit()
