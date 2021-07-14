extends Node
const Card = preload("res://scenes/Card.tscn")
const Auditor = preload("res://scenes/Auditor.tscn")

signal card_played

onready var deck = $Panel/Table/Left/PlayerDeck
onready var followers = $Panel/Table/Left/Followers
onready var hand = $Panel/Table/Right/PlayerHand
onready var arena = $PlayerArena
var card_set = []

func _init():	
	for i in range(10):
		# TODO: replace instance by using only property (here: number)
		var card = Card.instance()
		card.number = i
		card_set.append(card)

func start_set():
	self.reset_deck()
	for _i in range(3):
		var res = self.draw_card()
		if res is GDScriptFunctionState:
			yield(res, "completed")

func start_turn():
	arena.slot.droppable = true
	yield(self, "card_played")
	if deck.slot.card:
		var res = self.draw_card()
		if res is GDScriptFunctionState:
			yield(res, "completed")
	elif hand.is_empty():
		self.start_set()

func reset_deck():
	card_set.shuffle()
	for card in card_set:
		var new_card = card.duplicate()
		new_card.number = card.number
		deck.add_card(new_card)

func draw_card():
	var slot = hand.first_empty_slot()
	if slot:
		var card = deck.draw_card()
		if card:
			yield(hand.add_card(card), "completed")

func followers_first_empty_slot():
	var follower = Auditor.instance()
	for panel in followers.get_children():
		if panel.get_child_count() == 0:
			return panel
	return null

func _on_PlayerArena_card_played():
	emit_signal("card_played")

