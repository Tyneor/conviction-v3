extends Node2D

const Card = preload("res://scenes/Card.tscn")
const Slot = preload("res://scenes/Slot.gd")

onready var slots = $SlotContainer.get_children()

func _ready():
	for slot in slots:
		slot.droppable = true
#	init_hand()

func first_empty_slot():
	for slot in self.slots:
		if slot.card == null:
			return slot
	return null

func add_card(card):
	var slot = self.first_empty_slot()
	if slot:
		card.draggable = true
		var duration = slot.drop_in(card)
		card.reveal(duration)
