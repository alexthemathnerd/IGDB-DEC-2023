class_name Player
extends CharacterBody2D

enum States {IDLE, WALKING, DEATH, HIT}

@onready var animation_player = $Graphics/Animations

@export var health: int = 50
@export var bullet_scene: PackedScene
@export var move_speed = 200
@export var shoot_distance = 10000

var _state : int = States.IDLE
var _move_dir: Vector2 = Vector2.ZERO

var in_hit_state = false
var dead = false

func _ready():
	pass

func _process(_delta):
	if dead:
		return
		
	if Input.is_action_just_pressed("shoot"):
		shoot()
	var mouse_pos = get_global_mouse_position()
	var player_pos = global_position
	var to_mouse = mouse_pos - player_pos
	
	var is_mouse_left = to_mouse.x < 0
	animation_player.flip_h = is_mouse_left
	
	var angle_to_mouse = (mouse_pos - player_pos).angle()
	if is_mouse_left:
		angle_to_mouse -= PI

func _physics_process(_delta):
	if dead or in_hit_state:
		return
	_move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if _move_dir.x != 0:
		animation_player.flip_h = _move_dir.x < 0
	update_state_based_on_movement()
	velocity = _move_dir * move_speed
	move_and_slide()


func take_damage(damage_amount: int):
	health -= damage_amount
	if health <= 0:
		die()
	else:
		set_state(States.HIT)

func die():
	if dead:
		return
	dead = true
	set_state(States.DEATH)

func shoot():
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = global_position
	bullet_instance.direction = direction
	get_parent().add_child(bullet_instance)

func update_state_based_on_movement():
	if _move_dir != Vector2.ZERO:
		set_state(States.WALKING)
	else:
		set_state(States.IDLE)


func set_state(new_state: int):
	_state = new_state
	match _state:
		States.IDLE:
			animation_player.play("Idle")
		States.WALKING:
			animation_player.play("Walk")
		States.DEATH:
			animation_player.play("Death")
		States.HIT:
			animation_player.play("Hit")
			in_hit_state = true


func _on_death_timer_timeout():
	set_state(States.DEATH)


func _on_animations_animation_finished():
	if animation_player.animation == "Hit":
		in_hit_state = false
		update_state_based_on_movement()
