extends Node

const ScoreStore = preload("res://stores/ScoreStore.tres")
const Auditor = preload("res://scenes/ladders/Auditor.tscn")

onready var steps_container = $StepsContainer
onready var tween = $Tween
var arrow : Arrow

var auditor : Node2D setget set_auditor
var previous_auditor_parent : Panel

func _ready():
	self.arrow = Arrow.new()
	self.arrow.visible = false
	self.add_child(arrow)
	
func get_steps() -> Array:
	return self.steps_container.get_children()

func set_auditor(new_auditor):
	assert(new_auditor == null or auditor == null)
	auditor = new_auditor
	
func move_auditor_to(step):
	assert(self.auditor != null)
	var res = auditor.move_to_parent(step)
	if res is GDScriptFunctionState:
		yield(res, "completed")

func draw_arrow_to(step):
	assert(self.auditor != null and auditor.find_parent("StepsContainer"))
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
