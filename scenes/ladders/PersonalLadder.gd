extends "res://scenes/ladders/Ladder.gd"

func _ready():
	._ready()
	var steps = self.get_steps()
	assert(steps.size() % 2 == 1) # required to have a half
	var half = int(float(steps.size()) / 2)
	ScoreStore.min_score = - half
	ScoreStore.max_score = steps.size() - 1 - half

func move_auditor():
	var steps = self.get_steps()
	var half = int(float(steps.size()) / 2)
	var step : Panel = steps[ScoreStore.score + half]
	var res = .move_auditor_to(step)
	if res is GDScriptFunctionState:
		yield(res, "completed")

func draw_arrow(next_score):
	var steps = self.get_steps()
	var half = int(float(steps.size()) / 2)
	var step : Panel = steps[next_score + half]
	.draw_arrow_to(step)
