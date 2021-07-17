class_name PersonalBonus extends Power

var value := 0

func _init(new_value: int):
	self.value = new_value

func get_name():
	return str(self.value)
