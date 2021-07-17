class_name Swap extends Power

var min_value = 1
var max_value = 4
var otherwise : PersonalBonus

func _init(new_min=1, new_max=4, new_otherwise=null):
	self.min_value = new_min
	self.max_value = new_max
	if new_otherwise is PersonalBonus:
		self.otherwise = new_otherwise
	else:
		self.otherwise = PersonalBonus.new(0)

func get_name():
	return "Swap"
