class_name EnemyManager
extends Node2D

@export
var spawn_radius: float = 500

@onready
var enemy_base = preload("res://Enemy/Enemy.tscn")

func spawn():
	var enemy: Enemy = enemy_base.instantiate() 
	var random_angle = randf_range(-PI, PI)
	var spawn_position = Vector2(spawn_radius * cos(random_angle), spawn_radius * sin(random_angle))
	enemy.position = spawn_position + global_position
	enemy.target = get_parent()
	if randf() > 0.67:
		enemy.inital_data = load("res://Enemy/Demon/DemonData.tres")
	elif randf() > 0.33:
		enemy.inital_data = load("res://Enemy/Minotaur/MinotaurData.tres")
	else:
		enemy.inital_data = load("res://Enemy/Ogre/OgreData.tres")
		
	get_parent().get_parent().add_child(enemy)


func _on_cooldown_timeout():
	spawn()
