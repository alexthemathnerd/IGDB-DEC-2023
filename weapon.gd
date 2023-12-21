extends Node2D

@export var bullet_scene: PackedScene

@onready
var animated_sprite = $AnimatedSprite2D

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
	

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
