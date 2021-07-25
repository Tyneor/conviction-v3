extends Node

const ScoreStore = preload("res://stores/ScoreStore.tres")
const Auditor = preload("res://scenes/ladders/Auditor.tscn")

onready var vbox_container = $VBoxContainer
onready var tween = $Tween
var arrow : Arrow

var auditor : Node2D setget set_auditor
var previous_auditor_parent : Panel

func _ready():
	self.arrow = Arrow.new()
	self.arrow.visible = false
	self.add_child(arrow)
	
	var steps = vbox_container.get_children()
	assert(steps.size() % 2 == 1) # required to have a half
	var half = int(float(steps.size()) / 2)
	ScoreStore.min_score = - half
	ScoreStore.max_score = steps.size() - 1 - half

func set_auditor(new_auditor):
	assert(new_auditor == null or auditor == null)
	auditor = new_auditor
	
func move_auditor():
	assert(self.auditor != null)
	var steps = vbox_container.get_children()
	var half = int(float(steps.size()) / 2)
	var step : Panel = steps[ScoreStore.score + half]
		
	var res = auditor.move_to_parent(step)
	if res is GDScriptFunctionState:
		yield(res, "completed")

func draw_arrow_to(next_score):
	if auditor.find_parent("Ladder"):
		var steps = vbox_container.get_children()
		var half = int(float(steps.size()) / 2)
		var step : Panel = steps[next_score + half]
		var previous_position = auditor.get_parent().rect_global_position + auditor.get_parent().rect_size / 2
		var next_position = step.rect_global_position + step.rect_size / 2
		self.arrow.global_position = previous_position
		self.arrow.visible = true
		tween.interpolate_property(self.arrow, "length", 0, next_position.y - previous_position.y, 0.2)
		tween.start()
		
func hide_arrow():
#	tween.interpolate_property(self.arrow, "length", null, 0, 0.1)
#	tween.start()
#	yield(tween, "tween_completed")
	self.arrow.visible = false
