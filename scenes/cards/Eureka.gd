class_name Eureka extends Card
func get_class(): return "Eureka"

var personal_opinion := 3

func _ready():
	self.label = self.get_class()
	self.set_font_size(40)

func get_description():
	return "You gain + %d personal opinion regardless of the opponent's card" % self.personal_opinion

func compare_with(other_card) -> int:
	.compare_with(other_card)
	if other_card.get_class() == "Eureka":
		return self.personal_opinion - other_card.personal_opinion
	return self.personal_opinion
