extends Control


func set_label(label):
	$VBoxContainer/Label.text = label

func _on_MenuButton_pressed():
	get_tree().change_scene("res://scenes/MenuScreen.tscn")
