class_name Wave
extends Node

var _current_pulse: int
var _wave_data: WaveData

var spawner: WaveSpawner

@onready var wave_pulse: Timer = $WavePulse
@onready var enemy_base = preload("res://Enemy/Enemy.tscn")

func _ready():
	await owner.ready
	spawner = owner as WaveSpawner

func init(wave_data: WaveData):
	_current_pulse = 1
	_wave_data = wave_data
	wave_pulse.wait_time = _wave_data.length / _wave_data.pulse_amount

func start():
	var number = int(lerp(_wave_data.min_enemy_count, _wave_data.max_enemy_count, _current_pulse/float(_wave_data.pulse_amount)))
	for tmp in range(number):
		_spawn(_wave_data.get_enemy())
	_current_pulse += 1
	wave_pulse.start()

func stop():
	wave_pulse.stop()


func _on_wave_pulse():
	print("Current Pulse: ", _current_pulse)
	if _current_pulse < _wave_data.pulse_amount:
		var number = int(lerp(_wave_data.min_enemy_count, _wave_data.max_enemy_count, _current_pulse/float(_wave_data.pulse_amount)))
		for tmp in range(number):
			_spawn(_wave_data.get_enemy())
		_current_pulse += 1
		wave_pulse.start()

func _spawn(enemy_type: String):
	var enemy: Enemy = enemy_base.instantiate()
	var data: EnemyData = EnemyData.get_data(enemy_type)
	data.health = 2
	data.speed = 100
	enemy.initial_data = data
	enemy.target = spawner.get_node(spawner.target)
	enemy.request_ready()
	
	var random_angle = randf_range(-PI, PI)
	var spawn_position = Vector2(spawner.spawn_radius * cos(random_angle), spawner.spawn_radius  * sin(random_angle))
	enemy.position = spawn_position + spawner.global_position
	get_node(spawner.spawn_area).owner.add_child(enemy)

