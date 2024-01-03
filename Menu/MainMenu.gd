extends Control


func _on_play_pressed():
	Global.game.unload_menu()
	Global.game.load_level("Demo")
	


func _on_exit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	Global.game.unload_menu()
	Global.game.load_menu("SettingsMenu")
