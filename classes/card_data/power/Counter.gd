class_name Counter extends Power

var min_value = 1
var max_value = 6
var otherwise : PersonalBonus

func _init(new_min=1, new_max=6, new_otherwise=null):
	self.min_value = new_min
	self.max_value = new_max
	if new_otherwise is PersonalBonus:
		self.otherwise = new_otherwise
	else:
		self.otherwise = PersonalBonus.new(0)

func get_name():
	return "Counter"
