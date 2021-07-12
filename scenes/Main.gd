extends Node

const Card = preload("res://scenes/Card.tscn")

onready var player_deck = $PlayerDeck
onready var player_hand = $PlayerHand
onready var player_arena = $PlayerArena
onready var opponent_deck = $OpponentDeck
onready var opponent_hand = $OpponentHand
onready var opponent_arena = $OpponentArena

func _ready():
	randomize()
	init_player_deck()
	init_opponent_deck()

func init_player_deck():
	for i in range(10):
		var card = Card.instance()
		card.number = i
		player_deck.add_card(card)
		
func init_opponent_deck():
	for i in range(10):
		var card = Card.instance()
		card.number = i
		opponent_deck.add_card(card)

func _on_DrawButton_pressed():
	var slot = player_hand.first_empty_slot()
	if slot:
		var card = player_deck.draw_card()
		if card:
			player_hand.add_card(card)
			
func _on_FightButton_pressed():
	player_arena.play_card()

func _on_OpponentDrawButton_pressed():
	var slot = opponent_hand.first_empty_slot()
	if slot:
		var card = opponent_deck.draw_card()
		if card:
			opponent_hand.add_card(card)

func _on_OpponentPlayButton_pressed():
	var card = opponent_hand.get_random_card()
	if card:
		opponent_arena.add_card(card)
