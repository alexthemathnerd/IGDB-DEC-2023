class_name UI
extends Control


func _process(delta):
	$RichTextLabel.text = str(Engine.get_frames_per_second())
	
