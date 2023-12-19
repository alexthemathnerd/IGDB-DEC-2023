class_name Bat
extends CharacterBody2D

@export
var speed: float = 100
var player_position: Vector2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var direction = (player_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
