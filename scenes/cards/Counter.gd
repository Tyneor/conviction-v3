class_name Counter extends Card
func get_class(): return "Counter"

var min_value := 1
var max_value := 6
var otherwise : Argument

func _init():
	self.otherwise = Argument.new()
	self.otherwise.value = 0

func _ready():
	self.label = self.get_class()
	self.set_font_size(40)
	
func get_description():
	return "If the opponent card is between %d and %d you gain its value, otherwise, %s" % [self.min_value, self.max_value, self.otherwise.description]

func compare_with(other_card) -> int:
	.compare_with(other_card)
	if other_card.get_class() == "Argument" and other_card.value >= self.min_value and other_card.value <= self.max_value:
			return other_card.value
	if other_card.get_class() in ["Counter", "Swap"]:
		return self.otherwise.compare_with(other_card.otherwise)
	return self.otherwise.compare_with(other_card)
