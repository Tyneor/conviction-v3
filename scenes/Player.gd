extends Node

const Card = preload("res://scenes/Card.tscn")

signal card_played

onready var player_deck = $Panel/HBoxContainer/VBoxContainer/PlayerDeck
onready var player_hand = $Panel/HBoxContainer/PlayerHand
onready var player_arena = $PlayerArena
var card_set = []

func _init():	
	for i in range(10):
		# TODO: replace instance by using only property (here: number)
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
	player_arena.slot.droppable = true
	yield(self, "card_played")
	var res = self.draw_card()
	if res is GDScriptFunctionState:
		yield(res, "completed")

func reset_deck():
	card_set.shuffle()
	for card in card_set:
		var new_card = card.duplicate()
		new_card.number = card.number
		player_deck.add_card(new_card)

func draw_card():
	var slot = player_hand.first_empty_slot()
	if slot:
		var card = player_deck.draw_card()
		if card:
			yield(player_hand.add_card(card), "completed")

func _on_PlayerArena_card_played():
	emit_signal("card_played")

