class_name Enemy
extends CharacterBody2D

var target: Node2D = null

@export
var initial_data: EnemyData

@onready
var _speed = 100

@onready
var _health: int

@onready
var _animation_sprite: AnimatedSprite2D = $EnemyAnimation

@onready
var _hitbox: CollisionShape2D = $EnemyHitbox

@onready
var _state_machine: StateMachine = $StateMachine

func _ready():
	if initial_data != null:
		_health = initial_data.health
		_speed = initial_data.speed
		_animation_sprite.sprite_frames = initial_data.animation
		_hitbox.shape = initial_data.hitbox

func _move():
	if target != null:
		velocity = (target.position - position).normalized() * _speed
		_animation_sprite.flip_h = velocity.x < 0
		move_and_slide()
		

func damage(amount: int):
	_health -= amount
	if _health >= 1:
		_state_machine.transition_to("EnemyHurt")
	

func _die():
	_hitbox.disabled = true
	_animation_sprite.play("Die")
	await _animation_sprite.animation_finished
	queue_free()
