class_name Eureka extends Card
func get_class(): return "Eureka"

var value := 3

func _ready():
	self.label = self.get_class()

func compare_with(other_card) -> int:
	.compare_with(other_card)
	if other_card.get_class() == "Eureka":
		return self.value - other_card.value
	return self.value
