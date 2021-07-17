class_name Argument extends Card
func get_class(): return "Argument"

var value := 0 setget set_value

func set_value(new_value):
	value = new_value
	self.label = str(self.value)

func get_description():
	return "+ %d personal opinion" % self.value

func compare_with(other_card):
	.compare_with(other_card)
	if other_card.get_class() in ["Counter", "Eureka", "Swap"]:
		match other_card.compare_with(self):
			"swap":
				return "swap"
			var score_delta:
				return - score_delta
	return self.value - other_card.value
	
