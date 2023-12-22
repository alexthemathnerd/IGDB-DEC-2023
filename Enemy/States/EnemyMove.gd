extends EnemyState

func enter(_msg := {}) -> void:
	enemy._animation_sprite.play("Move")

func update(_delta: float) -> void:
	if enemy._health <= 0:
		state_machine.transition_to("EnemyDie")
	enemy._move()
