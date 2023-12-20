class_name EnemyHurt
extends EnemyState

func enter(_msg := {}) -> void:
	enemy._animation_sprite.play("Hurt")
	await enemy._animation_sprite.animation_finished
	state_machine.transition_to("EnemyMove")
