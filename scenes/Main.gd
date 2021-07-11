extends Node

const Card = preload("res://scenes/Card.tscn")

onready var deck = $Deck
onready var hand = $Hand
onready var arena = $Arena

func _ready():
	randomize()
	for i in range(10):
		var card = Card.instance()
		card.number = i
		deck.add_card(card)

func _on_DrawButton_pressed():
	var slot = hand.first_empty_slot()
	if slot:
		var card = deck.draw_card()
		if card:
			hand.add_card(card)

func _on_FightButton_pressed():
	var card = arena.slot.unset_card()
	if card:
		card.queue_free()
