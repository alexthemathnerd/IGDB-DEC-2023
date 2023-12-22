class_name Bullet
extends Area2D



@export var speed = 400
var direction = Vector2()

func _ready():
	var despawn_timer = $DespawnTimer
	despawn_timer.start()

func _physics_process(delta):
	var velocity = direction * speed
	position += velocity * delta


func _on_body_entered(body):
	if body is Enemy:
		(body as Enemy).damage(1)
	queue_free()


func _on_despawn_timer_timeout():
	queue_free()
