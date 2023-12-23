class_name BananaPeel
extends Area2D



func _on_death_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body is Enemy:
		(body as Enemy).slow()
