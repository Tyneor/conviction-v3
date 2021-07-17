extends Node

const ScoreStore = preload("res://stores/ScoreStore.tres")
const Auditor = preload("res://scenes/Auditor.tscn")

onready var player = $Player
onready var opponent = $Opponent
onready var ladder = $Ladder
var game_running = false
var current_orator
var auditors = []

func _ready():
	randomize()
	self.game_running = true
	for _i in range(7):
		self.auditors.append(Auditor.instance())
	self.start_new_round()
	self.player.start_set()
	self.opponent.start_set()
	self.current_orator = player

	while self.game_running:
		yield(current_orator.start_turn(), "completed")
		var res = self.showdown()
		if res is GDScriptFunctionState:
			yield(res, "completed")
		
		if self.game_running:
			if current_orator == player:
				current_orator = opponent
			else:
				current_orator = player
			if current_orator.arena.slot.card:
					current_orator.arena.delete_card()
	
	if player.followers_first_empty_slot() == null:
		$Label.text = "Congratulations,\n you won !"
	elif opponent.followers_first_empty_slot() == null:
		$Label.text = "Oh no...,\n you lost"
	else:
		$Label.text = "Nobody won,\n something wrong happened ;/"

func showdown():
	var player_card = player.arena.slot.card
	var opponent_card = opponent.arena.slot.card
	if player_card and opponent_card: # aka not the first turn
		match player_card.compare_with(opponent_card):
			"swap":
				ScoreStore.score = - ScoreStore.score
			var score_delta:
				ScoreStore.score += score_delta
		var res = ladder.move_auditor()
		if res is GDScriptFunctionState:
			yield(res, "completed")
		if ScoreStore.score == ScoreStore.min_score:
			self.finish_current_round(opponent)
			self.start_new_round()
		if ScoreStore.score == ScoreStore.max_score:
			self.finish_current_round(player)
			self.start_new_round()

func finish_current_round(round_winner):
	var auditor = ladder.auditor
	auditor.move_to_parent(round_winner.followers_first_empty_slot())
	ladder.auditor = null
	if round_winner.followers_first_empty_slot() == null:
		self.game_running = false

func start_new_round():
	var auditor = auditors.pop_back()
	if auditor:
		ladder.auditor = auditor
		ScoreStore.score = 0
		ladder.move_auditor()
