extends Control

func set_label(label):
	$VBoxContainer/VBoxContainer/Label.text = label

func set_game_score(player_score, opponent_score):
	$VBoxContainer/VBoxContainer/Score.text = str(player_score) + " - " + str(opponent_score)

func _on_MenuButton_pressed():
	SceneSwitcher.change_scene("res://scenes/screens/MenuScreen.tscn")
