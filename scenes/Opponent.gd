extends Node
const Card = preload("res://scenes/Card.tscn")

signal end_turn

onready var opponent_deck = $OpponentDeck
onready var opponent_hand = $OpponentHand
onready var opponent_arena = $OpponentArena
var cards = []

func _ready():
	for i in range(10):
		var card = Card.instance()
		card.number = i
		cards.append(card)

func init_deck():
	for card in cards:
		opponent_deck.add_card(card.duplicate())

func _on_DrawButton_pressed():
	var slot = opponent_hand.first_empty_slot()
	if slot:
		var card = opponent_deck.draw_card()
		if card:
			opponent_hand.add_card(card)

func _on_PlayButton_pressed():
	var card = opponent_hand.get_random_card()
	if card:
		opponent_arena.add_card(card)
