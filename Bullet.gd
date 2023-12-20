class_name Bullet
extends Area2D



@export var speed = 400
var direction = Vector2()




func _physics_process(delta):
	var velocity = direction * speed
	position += velocity * delta


func _on_body_entered(body):
	if body is Enemy:
		(body as Enemy).damage(1)
	queue_free()
