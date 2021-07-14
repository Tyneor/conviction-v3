extends Node

const Auditor = preload("res://scenes/Auditor.tscn")
const Card = preload("res://scenes/Card.tscn")

onready var player = $Player
onready var opponent = $Opponent
onready var ladder = $Ladder
var game_running = false
var auditors = []

func _ready():
	randomize()
	self.game_running = true
	for _i in range(7):
		self.auditors.append(Auditor.instance())
	self.set_new_auditor()
	self.player.start_set()
	self.opponent.start_set()

	while self.game_running:
		yield(player.start_turn(), "completed")
		var showdown_player = self.showdown(true)
		if showdown_player is GDScriptFunctionState:
			yield(showdown_player, "completed")
		
		if self.game_running:
			yield(opponent.start_turn(), "completed")
			var showdown_opponent = self.showdown(false)
			if showdown_opponent is GDScriptFunctionState:
				yield(showdown_opponent, "completed")
	
	if player.followers_first_empty_slot() == null:
		$Label.text = "Congratulations,\n you won !"
	elif opponent.followers_first_empty_slot() == null:
		$Label.text = "Oh no...,\n you lost"
	else:
		$Label.text = "Nobody won,\n something wrong happened ;/"

func showdown(is_last_orator_player):
	var player_card = player.arena.slot.card
	var opponent_card = opponent.arena.slot.card
	if player_card and opponent_card:
		var player_won_round
		var res = ladder.set_score(ladder.score + player_card.number - opponent_card.number)
		if res is GDScriptFunctionState:
			player_won_round = yield(res, "completed")
		if player_won_round != null:
			var auditor = ladder.auditor
			var winning_orator = player if player_won_round else opponent
			auditor.move_to_parent(winning_orator.followers_first_empty_slot())
			ladder.auditor = null
			if winning_orator.followers_first_empty_slot() == null:
				self.game_running = false
				return
			self.set_new_auditor()
				
		if is_last_orator_player:
			opponent.arena.delete_card()
		else:
			player.arena.delete_card()

func set_new_auditor():
	var auditor = auditors.pop_back()
	if auditor:
		ladder.auditor = auditor
		ladder.score = 0
