extends Node2D

const Card = preload("res://scenes/Card.tscn")

onready var slot = $Slot
var cards : Array = []

func add_card(card):
	if slot.card == null:
		slot.card = card
	else:
		self.cards.append(card)

func draw_card():
	var old_card = slot.unset_card()
	if self.cards.size() > 0:
		slot.card = cards.pop_front()	
	return old_card
