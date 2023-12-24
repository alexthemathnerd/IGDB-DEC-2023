class_name Player
extends CharacterBody2D

enum States {IDLE, WALKING, DEATH, HIT}

@onready var animation_player = $Graphics/Animations

@export var health: int = 50
@export var move_speed = 200
@export var shoot_distance = 10000

signal player_died
signal player_hurt(amount: int)

var _state : int = States.IDLE
var _move_dir: Vector2 = Vector2.ZERO
var is_animation_finished = true;
var in_hit_state = false
var is_dead = false

func _ready():
	pass

func _process(_delta):
	if is_dead:
		return
	var mouse_pos = get_global_mouse_position()
	var player_pos = global_position
	var to_mouse = mouse_pos - player_pos
	
	var is_mouse_left = to_mouse.x < 0
	animation_player.flip_h = is_mouse_left
	
	var angle_to_mouse = (mouse_pos - player_pos).angle()
	if is_mouse_left:
		angle_to_mouse -= PI

func _physics_process(_delta):
	if is_dead:
		return
	_move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	update_state_based_on_movement()
	velocity = _move_dir * move_speed
	move_and_slide()


func take_damage(damage_amount: int):
	player_hurt.emit(damage_amount)
	health -= damage_amount
	if health <= 0:
		die()
	elif is_animation_finished:
		set_state(States.HIT)
		

func die():
	if is_dead:
		return
	is_dead = true
	set_state(States.DEATH)


func update_state_based_on_movement():
	if in_hit_state:
		set_state(States.HIT)
	elif _move_dir != Vector2.ZERO:
		set_state(States.WALKING)
	else:
		set_state(States.IDLE)


func set_state(new_state: int):
	if new_state == States.HIT and not is_animation_finished:
		return
	_state = new_state
	match _state:
		States.IDLE:
			animation_player.play("Idle")
		States.WALKING:
			animation_player.play("Walk")
		States.DEATH:
			animation_player.play("Death")
			$DeathSound.play()
			player_died.emit()
		States.HIT:
			$HurtSound.play()
			in_hit_state = true
			is_animation_finished = false
			animation_player.play("Hit")
			
func get_is_dead():
	return is_dead


func _on_death_timer_timeout():
	set_state(States.DEATH)


func _on_animations_animation_finished():
	if animation_player.animation == "Hit":
		in_hit_state = false
		is_animation_finished = true
	update_state_based_on_movement()
