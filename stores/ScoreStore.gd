extends Resource

var personal_score := 0 setget set_personal_score
var min_p_score := 0 # opponent won
var max_p_score := 0 # player won

var global_score := 0 setget set_global_score
var min_g_score := 0
var max_g_score := 0

func set_personal_score(new_personal_score: int):
	personal_score = int(clamp(new_personal_score, self.min_p_score, self.max_p_score))

func set_global_score(new_global_score: int):
	global_score = int(clamp(new_global_score, self.min_g_score, self.max_g_score))

func reset_personal_score():
	self.personal_score = self.global_score
