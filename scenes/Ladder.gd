extends Node

const Auditor = preload("res://scenes/Auditor.tscn")

onready var vbox_container = $VBoxContainer
onready var tween = $Tween
var auditor

func _ready():
	auditor = Auditor.instance()
	self.set_score(0)
	
func set_score(score):
	var steps = vbox_container.get_children()
	var half = int(float(steps.size()) / 2)
	var displayed_score = clamp(score + half, 0, steps.size() - 1)
	var step : Panel = steps[displayed_score]
	var old_step = auditor.get_parent()
	if not old_step:
		move_auditor(auditor, null, step)
	elif old_step != step:
		move_auditor(auditor, old_step, step)
	if displayed_score == 0:
		return "opponent"
	if displayed_score == steps.size() - 1:
		return "player"

func move_auditor(auditor, source_step: Panel, target_step : Panel):
	if not source_step:
		target_step.add_child(auditor)
		auditor.position += target_step.rect_size / 2
	else:
		var starting_position = auditor.global_position
		source_step.remove_child(auditor)
		target_step.add_child(auditor)
		var target_position = target_step.rect_global_position + target_step.rect_size / 2
		var speed = 300
		var duration = min((target_position - starting_position).length() / speed, 1)
		auditor.z_index = 1
		tween.interpolate_property(
			auditor, "global_position", 
			starting_position, target_position, duration)
		tween.start()
		yield(get_tree().create_timer(duration), "timeout")
		auditor.z_index = 0
		
# TEST WITH custom styles and style box flat 
#	var step_dup = step.duplicate()
#	var test = step.get("custom_styles")
#	print(test)
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
