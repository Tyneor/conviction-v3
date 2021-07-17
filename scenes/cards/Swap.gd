class_name Swap extends Card
func get_class(): return "Swap"

var min_value := 1
var max_value := 4
var otherwise : Argument

func _init():
	self.otherwise = Argument.new()
	self.otherwise.value = 0

func _ready():
	self.label = self.get_class()

func compare_with(other_card):
	.compare_with(other_card)
	if other_card.get_class() == "Argument" and other_card.value >= self.min_value and other_card.value <= self.max_value:
			return "swap"
	if other_card.get_class() in ["Counter", "Swap"]:
		return self.otherwise.compare_with(other_card.otherwise)
	return self.otherwise.compare_with(other_card)
