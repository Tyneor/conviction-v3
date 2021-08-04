class_name Orator extends Node

const TimerDetails = preload("res://scenes/orators/children/TimerDetails.tscn")
const Theater = preload("res://scenes/Theater.tscn")
const ArgumentScn = preload("res://scenes/cards/Argument.tscn")
const CounterScn = preload("res://scenes/cards/Counter.tscn")
const SwapScn = preload("res://scenes/cards/Swap.tscn")
const EurekaScn = preload("res://scenes/cards/Eureka.tscn")
const Auditor = preload("res://scenes/ladders/Auditor.tscn")

signal card_played

export var is_timer_used = false
onready var deck = $Panel/MarginContainer/Table/Top/Left/Deck
onready var followers = $Panel/MarginContainer/Table/Top/Left/Followers
onready var hand = $Panel/MarginContainer/Table/Top/Right/Hand
onready var progressBar : ProgressBar = $Panel/MarginContainer/Table/Bottom/ProgressBar
onready var arena = $Arena
onready var tween : Tween = $Tween

func start_game(max_followers, is_timer_used):
	self.followers.max_followers = max_followers
	self.is_timer_used = is_timer_used
	if not is_timer_used:
		$Panel/MarginContainer/Table/Bottom.visible = false
		yield(get_tree(),"idle_frame")
	else:
		$Panel/MarginContainer/Table/Bottom.connect("pressed", self, "display_timer_details")
	self.start_set()

func start_set():
	self.reset_deck()
	for _i in range(3):
		var res = self.draw_card()
		if res is GDScriptFunctionState:
			yield(res, "completed")

func reset_deck():
	var cards = []
	var argumentsStats = [[0, 1], [1, 0], [2, -1], [3, -1], [4, -2], [5, -2], [6, -3]]
	for argumentStats in argumentsStats:
		var argument = ArgumentScn.instance()
		argument.personal_opinion =	argumentStats[0]
		argument.global_opinion = argumentStats[1]
		cards.append(argument)
		
	cards.append(CounterScn.instance())
	cards.append(SwapScn.instance())
	cards.append(EurekaScn.instance())
	cards.shuffle()
	deck.cards = cards

func start_turn(max_duration=5):
	if is_timer_used:
		self.tween.interpolate_property(progressBar, "value", 100, 0, max_duration)
		self.tween.interpolate_callback(self, max_duration, "play_left_card")
		self.tween.start()
	
	yield(self, "card_played")
	if is_timer_used:
		self.tween.remove_all()
		self.progressBar.value = 0
		
	if deck.slot.card:
		var res = self.draw_card()
		if res is GDScriptFunctionState:
			yield(res, "completed")
	elif hand.is_empty():
		self.start_set()

func play_left_card():
	if arena.slot.card == null:
		var card = hand.get_leftmost_card()
		if card:
			arena.add_card(card)

func draw_card():
	var slot = hand.first_empty_slot()
	if slot:
		var card = deck.draw_card()
		if card:
			yield(hand.add_card(card), "completed")

func display_timer_details():
	var timerDetails = TimerDetails.instance()
	timerDetails.text = "You only have\n5 seconds to play"
	var theater = Theater.instance()
	theater.set_content(timerDetails)
	get_tree().current_scene.add_child(theater)

func _on_Arena_card_played():
	emit_signal("card_played")

