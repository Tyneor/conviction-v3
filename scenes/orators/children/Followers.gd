extends GridContainer

var max_followers := 0 setget set_max_followers
var nb_followers := 0

func set_max_followers(new_max=4):
	assert(self.max_followers == 0 and new_max > 0) # can't set max twice
	max_followers = new_max
	for _i in range(self.max_followers):
		var control = Control.new()
		control.rect_min_size = Vector2(60, 60)
		self.add_child(control)

func add_follower(auditor):
	var next_parent = self._first_empty_slot()
	if next_parent:
		self.nb_followers += 1
		auditor.move_to_parent(next_parent)

func is_full():
	return self.nb_followers == self.max_followers

func _first_empty_slot():
	for control in self.get_children():
		if control.get_child_count() == 0:
			return control
	return null
