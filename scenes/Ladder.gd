extends Node

const Auditor = preload("res://scenes/Auditor.tscn")

onready var vbox_container = $VBoxContainer

var auditor setget set_auditor
var score : int setget set_score

func set_auditor(new_auditor):
	assert(new_auditor == null or auditor == null)
	auditor = new_auditor
	
func set_score(new_score):
	assert(self.auditor != null)
	score = new_score
	var steps = vbox_container.get_children()
	var half = int(float(steps.size()) / 2)
	var displayed_score = clamp(self.score + half, 0, steps.size() - 1)
	var step : Panel = steps[displayed_score]
	var res = auditor.move_to_parent(step)
	if res is GDScriptFunctionState:
			yield(res, "completed")
	if displayed_score == 0:
		return false # opponent won round
	if displayed_score == steps.size() - 1:
		return true # player won round
		
# TEST WITH custom styles and style box flat 
#	var step_dup = step.duplicate()
#	var test = step.get("custom_styles")
#	vbox_container.add_child(step_dup)

#var panel = Panel.new()
#var style = StyleBoxFlat.new()
#style.bg_color = "#326bc65b"
#style.corner_radius_bottom_left = 40
#style.corner_radius_bottom_right = 40
#style.corner_radius_top_left = 40
#style.corner_radius_top_right = 40
#panel.rect_min_size = Vector2(40, 40)
#panel.set("custom_styles/panel", style)
#vbox_container.add_child(panel)
