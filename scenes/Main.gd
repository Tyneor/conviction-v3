extends Node

const MenuScreen = preload("res://scenes/MenuScreen.tscn")

onready var fazePlayer = $FazePlayer
onready var background = $Background
var current_scene : Node

func _ready():
	self.change_scene(MenuScreen.instance())

func change_scene(new_scene : Node):
	if current_scene:
		self.fazePlayer.play("fade_in")
		yield(self.fazePlayer,"animation_finished")
		self.current_scene.queue_free()
	self.background.add_child(new_scene)
	if current_scene:
		yield(get_tree().create_timer(0.1), "timeout")
		self.fazePlayer.play("fade_out")
	self.current_scene = new_scene
