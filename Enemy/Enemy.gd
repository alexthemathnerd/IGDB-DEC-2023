class_name Enemy
extends CharacterBody2D


var target: Node2D = null

@export var initial_data: EnemyData

@onready var _speed: float
var _org_speed: float

signal enemy_defeated

@onready var _health: int

@onready var _animation_sprite: AnimatedSprite2D = $EnemyAnimation

@onready var _hitbox: CollisionShape2D = $EnemyHitbox

@onready var _attack_hitbox: CollisionShape2D = $AttackArea/AttackHitbox

@onready var _state_machine: StateMachine = $StateMachine

@onready var _attack_cooldown: Timer = $AttackCooldown

func _ready():
	if initial_data != null:
		_health = initial_data.health
		_speed = initial_data.speed
		_org_speed = _speed
		_animation_sprite.sprite_frames = initial_data.animation
		_hitbox.shape = initial_data.hitbox

func _move():
	if target != null:
		velocity = (target.position - position).normalized() * _speed
		_animation_sprite.flip_h = velocity.x < 0
		move_and_slide()
		

func slow():
	_speed = _org_speed * 0.5
	await get_tree().create_timer(0.7).timeout
	_speed = _org_speed

func damage(amount: int):
	_health -= amount
	if _health >= 1:
		_state_machine.transition_to("EnemyHurt")
	

func _die():
	_hitbox.disabled = true
	_attack_hitbox.disabled = true
	_animation_sprite.play("Die")
	await _animation_sprite.animation_finished
	enemy_defeated.emit(self)
	queue_free()


func _on_attack(body: Player):
	body.take_damage(1)
	_attack_cooldown.start()
	
	

func _on_attack_cooldown_timeout():
	if Global.player != null:
		Global.player.take_damage(1)
	_attack_cooldown.start()


func _on_attack_exited(body):
	_attack_cooldown.stop()
