extends Button

func set_content(node : Node):
	$CenterContainer.add_child(node)

func _on_Theater_pressed():
	self.queue_free()