class_name Bat
extends CharacterBody2D

var target: Player = null

var _health: int = 5

signal died(bat: Bat)

var health: int:
	get:
		return _health
	set(value):
		_health = value
		if _health <= 0:
			died.emit(self)


func _physics_process(delta):
	if target != null:
		velocity = (target.position - position).normalized() * 100
		move_and_slide()
		
func take_damage():
	queue_free()
