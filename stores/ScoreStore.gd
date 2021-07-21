extends Resource

var score := 0 setget set_score
var min_score := 0 # opponent won
var max_score := 0 # player won

func set_score(new_score: int):
	score = int(clamp(new_score, self.min_score, self.max_score))
