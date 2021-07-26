extends CanvasLayer

func set_content(node : Node):
	$Button.add_child(node)

func _on_Button_pressed():
	self.queue_free()
