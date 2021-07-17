class_name Argument extends Card
func get_class(): return "Argument"

var value := 0 setget set_value

func set_value(new_value):
	value = new_value
	self.label = str(self.value)

func compare_with(other_card) -> int:
	.compare_with(other_card)
	if other_card.get_class() in ["Counter", "Eureka"]:
		return - other_card.compare_with(self)
	if other_card.get_class() == "Swap":
		return other_card.compare_with(self)
	return self.value - other_card.value
	
