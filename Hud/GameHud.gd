extends Control

@onready var hearts := $VBoxContainer/Hearts
@onready var _heart_texture = preload("res://assets/ui/Icon_Heart.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.player != null:
		Global.player.player_hurt.connect(_on_player_hurt)
		for indx in range(Global.player.health):
			var heart = TextureRect.new()
			heart.texture = _heart_texture
			heart.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
			hearts.add_child(heart)

func _on_player_hurt(damage: int):
	for i in range(damage):
		if hearts.get_child_count() != 0:
			hearts.remove_child(hearts.get_child(i))
