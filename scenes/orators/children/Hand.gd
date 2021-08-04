extends CenterContainer

const Slot = preload("res://scenes/orators/children/Slot.gd")

export var is_for_player = false
onready var slots = $SlotContainer.get_children()

func _ready():
	if is_for_player:
		for slot in slots:
			slot.droppable = true

func first_empty_slot():
	for slot in self.slots:
		if slot.card == null:
			return slot
	return null

func add_card(card):
	var slot = self.first_empty_slot()
	assert(slot != null)
	var duration = slot.drop_in(card)
	if is_for_player:
		card.draggable = true
	yield(card.play_draw_animation(duration, is_for_player), "completed")

func get_random_card():
	var filled_slots = []
	for slot in self.slots:
		if slot.card:
			filled_slots.append(slot)
	if filled_slots.size() > 0:
		var slot = filled_slots[randi() % filled_slots.size()]
		return slot.drag_off()
		
func get_leftmost_card():
	for slot in self.slots:
		if slot.card:
			return slot.drag_off()
	return null

func is_empty():
	for slot in self.slots:
		if slot.card != null:
			return false
	return true
