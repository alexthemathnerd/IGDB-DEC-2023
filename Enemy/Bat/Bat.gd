class_name Bat
extends CharacterBody2D

var target: Player = null

func _physics_process(delta):
	if target != null:
		velocity = (target.position - position).normalized() * 100
		move_and_slide()
		
func take_damage():
	queue_free()
