class_name Swap extends Card
func get_class(): return "Swap"

const ScoreStore = preload("res://stores/ScoreStore.tres")

var min_value := 1
var max_value := 4
var otherwise : Argument

func _init():
	self.otherwise = Argument.new()
	self.otherwise.value = 0

func _ready():
	self.label = self.get_class()

func compare_with(other_card) -> int:
	.compare_with(other_card)
	if other_card.get_class() == "Argument" and other_card.value >= self.min_value and other_card.value <= self.max_value:
			return - 2 * ScoreStore.score
	if other_card.get_class() in ["Counter", "Swap"]:
		return self.otherwise.compare_with(other_card)
	return - other_card.compare_with(self.otherwise)
