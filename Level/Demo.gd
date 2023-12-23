extends Node2D


func _ready():
	Global.player = $Player
	Global.game.load_hud("GameHud")

func _on_player_died():
	Global.game.load_menu("DeathMenu")
	Global.player = null
	Global.game.unload_level()
	Global.game.unload_hud()
