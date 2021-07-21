# SceneSwitcher.change_scene("res://<SceneName>.tscn")

extends CanvasLayer

signal scene_changed

onready var black = $Black
onready var animationPlayer = $AnimationPlayer

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func change_scene(path):
	print("test")
	animationPlayer.play("FadeIn")
	yield(animationPlayer, "animation_finished")
	current_scene.queue_free()
	var scene = ResourceLoader.load(path)
	current_scene = scene.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	animationPlayer.play_backwards("FadeIn")
	yield(animationPlayer, "animation_finished")
	emit_signal("scene_changed")	
