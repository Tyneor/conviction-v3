extends Node
const Card = preload("res://scenes/Card.tscn")

signal end_turn

onready var opponent_deck = $OpponentDeck
onready var opponent_hand = $OpponentHand
onready var opponent_arena = $OpponentArena
var card_set = []

func _ready():
	for i in range(10):
		var card = Card.instance()
		card.number = i
		card_set.append(card)

func init_deck():
	card_set.shuffle()
	for card in card_set:
		var new_card = card.duplicate()
		new_card.number = card.number
		opponent_deck.add_card(new_card)

func _on_DrawButton_pressed():
	var slot = opponent_hand.first_empty_slot()
	if slot:
		var card = opponent_deck.draw_card()
		if card:
			opponent_hand.add_card(card)

func _on_PlayButton_pressed():
	if opponent_arena.slot.card == null:
		var card = opponent_hand.get_random_card()
		if card:
			opponent_arena.add_card(card)
