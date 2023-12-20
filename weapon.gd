extends Node2D



func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var weapon_pos = global_position
	var to_mouse = mouse_pos - weapon_pos
	
	var is_mouse_left = to_mouse.x < 0
	$AnimatedSprite2D.flip_h = is_mouse_left
	
	var angle_to_mouse = (mouse_pos - weapon_pos).angle()
	if is_mouse_left:
		angle_to_mouse -= PI
	
	rotation = angle_to_mouse
	print(rotation)
