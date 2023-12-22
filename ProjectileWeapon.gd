class_name projectWeapon
extends Node2D

@export var bullet_scene: PackedScene
@onready
var fire_rate_timer: Timer = $FireRateTimer
var is_firing = false
var first_shot_fired = false
@onready
var animated_sprite = $AnimatedSprite2D

func _ready():
	set_fire_rate(0.15)

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
		first_shot_fired = false
		fire_rate_timer.start()
	if Input.is_action_just_pressed("shoot") and not first_shot_fired:
		is_firing = true
	if Input.is_action_just_released("shoot"):
		is_firing = false
		fire_rate_timer.stop()

	var mouse_pos = get_global_mouse_position()
	var weapon_pos = global_position
	var to_mouse = mouse_pos - weapon_pos
	
	var is_mouse_left = to_mouse.x < 0
	animated_sprite.flip_h = is_mouse_left
	
	var angle_to_mouse = (mouse_pos - weapon_pos).angle()
	if is_mouse_left:
		angle_to_mouse -= PI
	
	rotation = angle_to_mouse

func shoot():
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = position
	bullet_instance.direction = direction
	get_parent().add_child(bullet_instance)

func set_fire_rate(new_rate: float):
	fire_rate_timer.wait_time = new_rate

func _on_fire_rate_timer_timeout():
	if is_firing:
		first_shot_fired = true
		shoot()
