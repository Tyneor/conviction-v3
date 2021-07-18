extends Control

func set_label(label):
	$VBoxContainer/Label.text = label

func _on_MenuButton_pressed():
	var MenuScreen = load("res://scenes/MenuScreen.tscn").instance()
	self.get_tree().current_scene.change_scene(MenuScreen)
