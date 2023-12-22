class_name WaveSpawner
extends Node2D

@export var spawn_area: NodePath
@export var target: NodePath
@export var spawn_radius: int = 500

@onready var wave: Wave = $Wave

var _start = false

func _ready():
	var debug_wave: WaveData = preload("res://Wave/AllEnemy.tres")
	debug_wave.length = 30
	debug_wave.pulse_amount = 6
	debug_wave.min_enemy_count = 3
	debug_wave.max_enemy_count = 20
	wave.init(debug_wave)

func _process(delta):
	if not _start:
		wave.start()
		_start = true
