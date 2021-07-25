class_name Orator extends Node

const ArgumentScn = preload("res://scenes/cards/Argument.tscn")
const CounterScn = preload("res://scenes/cards/Counter.tscn")
const SwapScn = preload("res://scenes/cards/Swap.tscn")
const EurekaScn = preload("res://scenes/cards/Eureka.tscn")
const Auditor = preload("res://scenes/ladders/Auditor.tscn")

signal card_played

onready var deck = $Panel/Table/Left/Deck
onready var followers = $Panel/Table/Left/Followers
onready var hand = $Panel/Table/Right/Hand
onready var arena = $Arena

func start_set():
	self.reset_deck()
	for _i in range(3):
		var res = self.draw_card()
		if res is GDScriptFunctionState:
			yield(res, "completed")

func reset_deck():
	var cards = []
	for i in range(7):
		var argument = ArgumentScn.instance()
		argument.value = i
		cards.append(argument)
	cards.append(CounterScn.instance())
	cards.append(SwapScn.instance())
	cards.append(EurekaScn.instance())
	cards.shuffle()
	deck.cards = cards

func start_turn():
	yield(self, "card_played")
	if deck.slot.card:
		var res = self.draw_card()
		if res is GDScriptFunctionState:
			yield(res, "completed")
	elif hand.is_empty():
		self.start_set()

func draw_card():
	var slot = hand.first_empty_slot()
	if slot:
		var card = deck.draw_card()
		if card:
			yield(hand.add_card(card), "completed")

func _on_Arena_card_played():
	emit_signal("card_played")

