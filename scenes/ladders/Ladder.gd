extends Node

const ScoreStore = preload("res://stores/ScoreStore.tres")
const Auditor = preload("res://scenes/ladders/Auditor.tscn")

onready var vbox_container = $VBoxContainer
var arrow

var auditor : Node2D setget set_auditor

func _ready():
#	self.arrow = Arrow.new()
#	self.arrow.self_modulate.a = 0.5
#	self.arrow.visible = false
#	self.add_child(arrow)
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
	
#	if auditor.find_parent("Ladder"):
#		var previous_position = auditor.get_parent().rect_global_position + auditor.get_parent().rect_size / 2
#		var next_position = step.rect_global_position + step.rect_size / 2
#		self.arrow.global_position = previous_position
#		self.arrow.length = next_position.y - previous_position.y
#		self.arrow.visible = true
		
	var res = auditor.move_to_parent(step)
	if res is GDScriptFunctionState:
		yield(res, "completed")
