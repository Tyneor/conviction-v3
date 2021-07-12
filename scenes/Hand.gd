extends Node2D

const Card = preload("res://scenes/Card.tscn")
const Slot = preload("res://scenes/Slot.gd")

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
	if slot:
		var duration = slot.drop_in(card)
		if is_for_player:
			card.draggable = true
		card.play_draw_animation(duration, is_for_player)

func get_random_card():
	var filled_slots = []
	for slot in self.slots:
		if slot.card:
			filled_slots.append(slot)
	if filled_slots.size() > 0:
		var slot = filled_slots[randi() % filled_slots.size()]
		return slot.unset_card()
	
