extends Panel

const DragStore = preload("res://stores/DragStore.tres")

onready var tween = $Tween
var card = null setget set_card
var droppable = false

func _ready():
	DragStore.add_slot(self)

func is_in_drop_range(new_card):
	return droppable and new_card in $Area2D.get_overlapping_areas()

func set_card(new_card):
	card = new_card
	self.add_child(card)
	card.position = self.rect_size / 2

func drop_in(new_card):
	card = new_card
	var starting_position = new_card.global_position
	get_tree().current_scene.remove_child(new_card)
	self.add_child(card)
	var speed = 1000
	var target_position = rect_global_position + self.rect_size / 2
	var duration = min((target_position - starting_position).length() / speed, 0.3)
	tween.interpolate_property(card, "global_position", starting_position, target_position, duration)
	tween.start()
	return duration

func unset_card():
	var old_card = card
	if card:
		var previous_global_position = card.global_position
		self.remove_child(card)
		get_tree().current_scene.add_child(card)
		card.global_position = previous_global_position
		card = null
	return old_card
