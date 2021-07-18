extends Control

func _on_PlayButton_pressed():
	var GameScreen = load("res://scenes/GameScreen.tscn").instance()
	self.get_tree().current_scene.change_scene(GameScreen)
