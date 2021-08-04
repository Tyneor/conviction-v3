extends Control

func _on_PlayButton_pressed():
	var game_screen_instance = load("res://scenes/screens/GameScreen.tscn").instance()
	game_screen_instance.are_timers_used = false
	SceneSwitcher.change_scene(game_screen_instance)


func _on_PlayWithTimerButton_pressed():
	var game_screen_instance = load("res://scenes/screens/GameScreen.tscn").instance()
	game_screen_instance.are_timers_used = true
	SceneSwitcher.change_scene(game_screen_instance)
