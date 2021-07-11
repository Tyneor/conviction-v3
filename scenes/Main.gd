extends Node

const Card = preload("res://scenes/Card.tscn")

onready var Deck = $Deck
onready var Hand = $Hand
onready var Button = $Button

func _ready():
	randomize()
	for i in range(10):
		var card = Card.instance()
		card.number = i
		Deck.add_card(card)

func _on_Button_pressed():
	var slot = Hand.first_empty_slot()
	if slot:
		var card = Deck.Slot.unset_card()
		Hand.add_card(card)
