class_name UI
extends Control


func _process(_delta):
	$RichTextLabel.text = str(Engine.get_frames_per_second())
	
