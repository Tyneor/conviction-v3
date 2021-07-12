extends Node
const Card = preload("res://scenes/Card.tscn")

signal end_turn

onready var player_deck = $PlayerDeck
onready var player_hand = $PlayerHand
onready var player_arena = $PlayerArena
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
		player_deck.add_card(new_card)
		
func _on_DrawButton_pressed():
	var slot = player_hand.first_empty_slot()
	if slot:
		var card = player_deck.draw_card()
		if card:
			player_hand.add_card(card)

func _on_FightButton_pressed():
	player_arena.play_card()
