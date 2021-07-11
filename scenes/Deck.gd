extends Node2D

const Card = preload("res://scenes/Card.tscn")

onready var Slot = $Slot
var cards : Array = []

func add_card(card):
	if Slot.card == null:
		Slot.card = card
	else:
		self.cards.append(card)

func _on_Slot_card_removed():
	if self.cards.size() > 0:
		Slot.card = cards.pop_front()
