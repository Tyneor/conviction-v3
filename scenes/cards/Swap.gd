class_name Swap extends Card
func get_class(): return "Swap"

var min_personal_opinion := 1
var max_personal_opinion := 4
var otherwise : Argument

func _init():
	self.otherwise = Argument.new()
	self.otherwise.personal_opinion = 0

func _ready():
	self.label = self.get_class()
	self.set_font_size(50)

func get_description():
	return "If the opponent card is between %d and %d the current auditor swaps side, otherwise, %s" % [self.min_personal_opinion, self.max_personal_opinion, self.otherwise.description]

func compare_with(other_card):
	.compare_with(other_card)
	if other_card.get_class() == "Argument" and other_card.personal_opinion >= self.min_personal_opinion and other_card.personal_opinion <= self.max_personal_opinion:
			return "swap"
	if other_card.get_class() in ["Counter", "Swap"]:
		return self.otherwise.compare_with(other_card.otherwise)
	return self.otherwise.compare_with(other_card)
