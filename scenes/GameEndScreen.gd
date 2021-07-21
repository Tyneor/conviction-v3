extends Control

func set_label(label):
	$VBoxContainer/Label.text = label

func _on_MenuButton_pressed():
	SceneSwitcher.change_scene("res://scenes/MenuScreen.tscn")
