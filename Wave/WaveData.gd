class_name WaveData
extends Resource

@export var enemy_types: Array[String]
var _enemy_weights: Array[int]
@export var enemy_weights: Array[int]:
	get:
		return _enemy_weights
	set(value):
		_enemy_weights = value
		_total_weight = 0
		for enemy_weight in _enemy_weights:
			_total_weight += enemy_weight

var length: float
var pulse_amount: int
var min_enemy_count: int
var max_enemy_count: int

var _total_weight: int = 0

func get_enemy() -> String:
	var rand_int = randi_range(1, _total_weight)
	var curr_weight = 0
	for indx in range(len(_enemy_weights)):
		curr_weight += enemy_weights[indx]
		if rand_int <= curr_weight:
			return enemy_types[indx]
	return "DEMON"
