extends Control


func _on_replay_pressed():
	Global.game.unload_menu()
	Global.game.load_level("Demo")

func _on_exit_pressed():
	get_tree().quit()
