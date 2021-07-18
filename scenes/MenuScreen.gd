extends Control

func _on_PlayButton_pressed():
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://scenes/GameScreen.tscn")
