class_name Argument extends Card
func get_class(): return "Argument"

var personal_opinion := 0 setget set_personal_opinion
var global_opinion := 0 setget set_global_opinion

func set_personal_opinion(new_personal_opinion):
	personal_opinion = new_personal_opinion
	self.label = str(self.personal_opinion)
	
func set_global_opinion(new_global_opinion):
	global_opinion = new_global_opinion

func get_description():
	return "+ %d personal opinion\n%s %d global opinion" % [self.personal_opinion,"+" if sign(self.global_opinion) >= 0 else "-", abs(self.global_opinion)]

func compare_with(other_card):
	.compare_with(other_card)
	if other_card.get_class() in ["Counter", "Eureka", "Swap"]:
		match other_card.compare_with(self):
			"swap":
				return "swap"
			var score_delta:
				return - score_delta
	return self.personal_opinion - other_card.personal_opinion
	
