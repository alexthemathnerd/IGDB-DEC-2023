class_name EnemyManager
extends Node2D

@export
var spawn_radius: float = 50

@export 
var bat_scene: PackedScene

@onready
var spawn_path := $SpawnPath

@onready
var spawn_location := $SpawnPath/SpawnLocation

func _on_timer_timeout():
	var bat = bat_scene.instantiate()
	spawn_location.progress_ratio = randf()
	
	var direction = spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	bat.position = spawn_location.position

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	bat.velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(bat)
