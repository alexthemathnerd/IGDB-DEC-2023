extends Node2D

func _ready():
	$Player/EnemySpawner.world = self
