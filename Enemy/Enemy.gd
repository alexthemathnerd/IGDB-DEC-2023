class_name Enemy
extends CharacterBody2D

var target: Node2D = null

@export
var inital_data: EnemyData

@onready
var _speed = 100

@onready
var _health: int

var health: int:
	get:
		return _health
	set(value):
		_health = value
		if _health <= 0:
			die()

@onready
var _animation_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready
var _hitbox: CollisionShape2D = $CollisionShape2D


signal enemy_died
signal enemy_attack

func _ready():
	if EnemyData != null:
		_health = inital_data.health
		_speed = inital_data.speed
		_animation_sprite.sprite_frames = inital_data.animation
		_hitbox.shape = inital_data.hitbox
		_animation_sprite.play("Move")


func _physics_process(_delta):
	if target != null:
		velocity = (target.position - position).normalized() * _speed
		_animation_sprite.flip_h = velocity.x < 0
		move_and_slide()

func move():
	if target != null:
		velocity = (target.position - position).normalized() * _speed
		move_and_slide()

func damage(amount: int):
	_animation_sprite.play("Hurt")
	health -= amount

func die():
	enemy_died.emit()
	target = null
	_animation_sprite.play("Die")


func _on_animation_finished():
	if _animation_sprite.animation == "Die":
		queue_free()
