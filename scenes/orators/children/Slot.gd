extends Panel

const DragStore = preload("res://stores/DragStore.tres")

signal card_dropped
onready var tween = $Tween
var previous_card : Area2D
var card = null setget set_card
var droppable = false setget set_droppable

func _exit_tree():
	DragStore.remove_slot(self)	

func set_droppable(new_droppable):
	droppable = new_droppable
	if droppable:
		DragStore.add_slot(self)
	else:
		DragStore.remove_slot(self)

func set_card(new_card):
	card = new_card
	self.add_child(card)
	card.position = self.rect_size / 2

func delete_previous_card():
	if previous_card:
		previous_card.queue_free()
		previous_card = null

func delete_card():
	if previous_card != null:
		previous_card.queue_free()
		previous_card = null
	previous_card = card
	previous_card.modulate.a = 0.5
	card = null

func is_in_drop_range(new_card):
	return droppable and new_card in $Area2D.get_overlapping_areas()

func drop_in(new_card, speed=1000):
	assert(card == null, "dropped a card on a non-empty slot")
	card = new_card
	emit_signal("card_dropped")
	var starting_position = card.global_position
	var target_position = rect_global_position + self.rect_size / 2
	var duration = min((target_position - starting_position).length() / speed, 0.3)
	get_tree().current_scene.remove_child(new_card)
	self.add_child(card)
	card.global_position = starting_position
	tween.interpolate_property(card, "global_position", starting_position, target_position, duration)
	tween.start()
	return duration

func drag_off():
	var old_card = card
	if card:
		var previous_global_position = card.global_position
		self.remove_child(card)
		get_tree().current_scene.add_child(card)
		card.global_position = previous_global_position
		card = null
	return old_card
