class_name Player
extends CharacterBody2D

enum States {IDLE, WALKING, DEATH}

@export var bullet_scene: PackedScene
@onready var animation_player = $CollisionShape2D/Graphics/Animations
@export var move_speed = 200
@export var shoot_distance = 10000
var damage_amount = 15
var _state : int = States.IDLE

var dead = false

func _ready():
	#$DeathTimer.start()
	pass

func _process(_delta):
	if dead:
		return
		
	if Input.is_action_just_pressed("shoot"):
		shoot()
		

func _physics_process(_delta):
	if dead:
		return
	var move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if move_dir.x != 0:
		$CollisionShape2D/Graphics/Animations.flip_h = move_dir.x < 0
		
	if move_dir != Vector2.ZERO:
		set_state(States.WALKING)
		velocity = move_dir * move_speed
		move_and_slide()
	else:
		set_state(States.IDLE)
			

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



func set_state(new_state: int):
	_state = new_state
	match _state:
		States.IDLE:
			animation_player.play("Idle")
		States.WALKING:
			animation_player.play("Walk")
		States.DEATH:
			animation_player.play("Death")
			die()


func _on_death_timer_timeout():
	set_state(States.DEATH)
