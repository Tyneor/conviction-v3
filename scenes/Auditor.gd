extends Node2D

onready var tween = $Tween

func move_to_parent(target: Control, speed=300):
	var source = self.get_parent() # null if no previous parent
	if not source or speed == 0:
		if source:
			source.remove_child(self)
		target.add_child(self)
		self.position = target.rect_size / 2
	else:
		var starting_position = self.global_position
		var target_position = target.rect_global_position + target.rect_size / 2
		var duration = min((target_position - starting_position).length() / speed, 1)
		self.z_index = 1
		tween.interpolate_property(
				self, "global_position", 
				starting_position, target_position, duration)
		tween.start()
		yield(tween, "tween_completed")
		source.remove_child(self)
		target.add_child(self)
		self.position = target.rect_size / 2
		self.z_index = 0
