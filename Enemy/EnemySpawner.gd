class_name EnemyManager
extends Node2D

var world

@export
var spawn_radius: float = 50

@export
var bat_scene: PackedScene

func spawn():
	var bat = bat_scene.instantiate()
	var random_angle = randf_range(-PI, PI)
	var spawn_position = Vector2(spawn_radius * cos(random_angle), spawn_radius * sin(random_angle))
	bat.position = spawn_position + global_position
	bat.target = get_parent()
	get_parent().get_parent().add_child(bat)


func _on_cooldown_timeout():
	spawn()
