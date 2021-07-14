extends Node
const Card = preload("res://scenes/Card.tscn")

signal card_played

onready var opponent_deck = $Panel/HBoxContainer/VBoxContainer/OpponentDeck
onready var opponent_hand = $Panel/HBoxContainer/OpponentHand
onready var opponent_arena = $OpponentArena
var card_set = []

func _ready():
	for i in range(10):
		var card = Card.instance()
		card.number = i
		card_set.append(card)

func start_game():
	self.reset_deck()
	for _i in range(3):
		var res = self.draw_card()
		if res is GDScriptFunctionState:
			yield(res, "completed")

func start_turn():
	self.play_random_card()
	yield(self, "card_played")
	var res = self.draw_card()
	if res is GDScriptFunctionState:
		yield(res, "completed")

func reset_deck():
	card_set.shuffle()
	for card in card_set:
		var new_card = card.duplicate()
		new_card.number = card.number
		opponent_deck.add_card(new_card)

func draw_card():
	var slot = opponent_hand.first_empty_slot()
	if slot:
		var card = opponent_deck.draw_card()
		if card:
			yield(opponent_hand.add_card(card), "completed")

func play_random_card():
	print("Bot is thinking ...")
	yield(get_tree().create_timer(1.0), "timeout")
	if opponent_arena.slot.card == null:
		var card = opponent_hand.get_random_card()
		if card:
			opponent_arena.add_card(card)	

func _on_OpponentArena_card_played():
	emit_signal("card_played")
