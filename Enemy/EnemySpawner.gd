class_name EnemyManager
extends Node2D

@export
var spawn_radius: float = 500

@onready
var enemy_base = preload("res://Enemy/Enemy.tscn")

var _bat: EnemyData = preload("res://Enemy/Bat/BatData.tres")
var _ogre: EnemyData = preload("res://Enemy/Ogre/OgreData.tres")
var _demon: EnemyData = preload("res://Enemy/Demon/DemonData.tres")
var _minotaur: EnemyData = preload("res://Enemy/Minotaur/MinotaurData.tres")

func spawn():
	var enemy: Enemy = enemy_base.instantiate() 
	var random_angle = randf_range(-PI, PI)
	var spawn_position = Vector2(spawn_radius * cos(random_angle), spawn_radius * sin(random_angle))
	enemy.position = spawn_position + global_position
	enemy.target = get_parent()
	if randf() > 0.67:
		enemy.initial_data = _ogre
	elif randf() > 0.33:
		enemy.initial_data = _demon
	else:
		enemy.initial_data = _minotaur
		
	get_parent().get_parent().add_child(enemy)


func _on_cooldown_timeout():
	spawn()
