extends Node

const DragStore = preload("res://stores/DragStore.tres")
const ScoreStore = preload("res://stores/ScoreStore.tres")
const GameEndScreen = preload("res://scenes/screens/GameEndScreen.tscn")
const Theater = preload("res://scenes/Theater.tscn")
const Auditor = preload("res://scenes/ladders/Auditor.tscn")

onready var player = $Player
onready var opponent = $Opponent
onready var ladder = $Ladder
var game_running = false
var current_orator
var auditors = []

func _ready():
	randomize()
	yield(self.start_game(), "completed")
	finish_game()
	
func start_game():
	self.game_running = true
	var winning_nb_followers = 4
	for _i in range(winning_nb_followers * 2 - 1):
		self.auditors.append(Auditor.instance())
	self.player.followers.max_followers = winning_nb_followers
	self.opponent.followers.max_followers = winning_nb_followers
	self.start_new_round()
	self.player.start_set()
	self.opponent.start_set()
	self.current_orator = player
	
	DragStore.connect("card_dragged", self, "on_Card_dragged")
	DragStore.connect("card_dropped", self, "on_Card_dropped")

	while self.game_running:
		yield(current_orator.start_turn(), "completed")
		current_orator.arena.delete_previous_card()
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

func on_Card_dragged(card):
	var new_score = self._calcultate_next_score(card, opponent.arena.slot.card)
	if player.arena.slot.card == null:
		self.ladder.draw_arrow_to(new_score)
		
func on_Card_dropped():
	self.ladder.hide_arrow()

func showdown():
	var new_score = self._calcultate_next_score(player.arena.slot.card, opponent.arena.slot.card)
	ScoreStore.score = new_score
	var res = ladder.move_auditor()
	if res is GDScriptFunctionState:
		yield(res, "completed")
	if ScoreStore.score == ScoreStore.min_score:
		self.finish_current_round(opponent)
		self.start_new_round()
	if ScoreStore.score == ScoreStore.max_score:
		self.finish_current_round(player)
		self.start_new_round()

func _calcultate_next_score(player_card, opponent_card) -> int:
	if player_card and opponent_card: # aka not the first turn
		match player_card.compare_with(opponent_card):
			"swap":
				return - ScoreStore.score
			var score_delta:
				return int(clamp(ScoreStore.score + score_delta, ScoreStore.min_score, ScoreStore.max_score))
	return 0
	
func start_new_round():
	var auditor = auditors.pop_back()
	if auditor:
		ScoreStore.score = 0
		ladder.auditor = auditor
		ladder.move_auditor()

func finish_current_round(round_winner):
	var auditor = ladder.auditor
	round_winner.followers.add_follower(auditor)
	ladder.auditor = null
	if round_winner.followers.is_full():
		self.game_running = false

func finish_game():
	var screen = GameEndScreen.instance()
	if player.followers.is_full():
		screen.set_label("Congratulations,\n you won !")
	elif opponent.followers.is_full():
		screen.set_label("Oh no...,\n you lost")
	else:
		screen.set_label("Nobody won,\n something wrong happened ;/")
	var theater = Theater.instance()
	theater.set_content(screen)
	get_tree().current_scene.add_child(theater)
