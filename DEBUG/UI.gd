class_name UI
extends CanvasLayer


func _process(_delta):
	$HUD/RichTextLabel.text = str(Engine.get_frames_per_second())
	
