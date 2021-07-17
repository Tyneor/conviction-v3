extends Node

const ScoreStore = preload("res://stores/ScoreStore.tres")
const Auditor = preload("res://scenes/Auditor.tscn")

onready var vbox_container = $VBoxContainer

var auditor setget set_auditor

func _ready():
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
