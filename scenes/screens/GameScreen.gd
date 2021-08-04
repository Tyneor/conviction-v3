extends Node

const DragStore = preload("res://stores/DragStore.tres")
const ScoreStore = preload("res://stores/ScoreStore.tres")
const GameEndScreen = preload("res://scenes/screens/GameEndScreen.tscn")
const Theater = preload("res://scenes/Theater.tscn")
const Auditor = preload("res://scenes/ladders/Auditor.tscn")

export var are_timers_used := false
onready var player = $Player
onready var opponent = $Opponent
onready var personal_ladder = $PersonalLadder
onready var global_ladder = $GlobalLadder
var game_running = false
var current_orator
var auditors := []

func _ready():
	randomize()
	yield(self.start_game(), "completed")
	finish_game()
	
func start_game():
	self.game_running = true
	var winning_nb_followers = 4
	for i in range(winning_nb_followers * 2 - 1):
		var auditor = Auditor.instance()
		auditor.first_name = "Auditor"
		auditor.index = i
		auditor.set_color(Color(randf(), randf(), randf()))
		self.auditors.append(auditor)
	self.player.start_game(winning_nb_followers, are_timers_used)
	self.opponent.start_game(winning_nb_followers, are_timers_used)
	self.start_new_round()
	self.current_orator = player if randf() > 0.5 else opponent
	
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
	var new_personal_score = self._calculate_next_personal_score(card, opponent.arena.slot.card)
	var new_global_score = self._calculate_next_global_score(card)
	if player.arena.slot.card == null:
		personal_ladder.draw_arrow(new_personal_score)
		if global_ladder.auditor != null:
			global_ladder.draw_arrow(new_global_score)
		
func on_Card_dropped():
	personal_ladder.hide_arrow()
	global_ladder.hide_arrow()

func showdown():
	if global_ladder.auditor != null:
		ScoreStore.global_score = self._calculate_next_global_score(current_orator.arena.slot.card)
		var g_res = global_ladder.move_auditor()
		if g_res is GDScriptFunctionState:
			yield(g_res, "completed")
	
	ScoreStore.personal_score = self._calculate_next_personal_score(player.arena.slot.card, opponent.arena.slot.card)
	var p_res = personal_ladder.move_auditor()
	if p_res is GDScriptFunctionState:
		yield(p_res, "completed")
	
	if ScoreStore.personal_score == ScoreStore.min_p_score:
		self.finish_current_round(opponent)
	if ScoreStore.personal_score == ScoreStore.max_p_score:
		self.finish_current_round(player)
	

func _calculate_next_personal_score(player_card, opponent_card) -> int:
	if player_card and opponent_card: # aka not the first turn
		match player_card.compare_with(opponent_card):
			"swap":
				return - ScoreStore.personal_score
			var score_delta:
				return int(clamp(ScoreStore.personal_score + score_delta, ScoreStore.min_p_score, ScoreStore.max_p_score))
	return ScoreStore.personal_score

func _calculate_next_global_score(card) -> int:
	if card and card.get_class() == "Argument":
		var delta = (1 if self.current_orator == self.player else -1) * card.global_opinion
		return int(clamp(ScoreStore.global_score + delta, ScoreStore.min_g_score, ScoreStore.max_g_score))
	return ScoreStore.global_score
	
func start_new_round():
	ScoreStore.reset_personal_score()
	var auditor = global_ladder.auditor if global_ladder.auditor else auditors.pop_front()
	if auditor:
		personal_ladder.auditor = auditor
		global_ladder.auditor = null
		personal_ladder.move_auditor()
		
	var global_auditor = auditors.pop_front()
	if global_auditor:
		global_ladder.auditor = global_auditor
		global_ladder.move_auditor()

func finish_current_round(round_winner):
	var auditor = personal_ladder.auditor
	round_winner.followers.add_follower(auditor)
	personal_ladder.auditor = null
	if round_winner.followers.is_full():
		self.game_running = false
	else:
		self.start_new_round()

func finish_game():
	var screen = GameEndScreen.instance()
	if player.followers.is_full():
		screen.set_label("You won !")
	elif opponent.followers.is_full():
		screen.set_label("You lost ...")
	else:
		screen.set_label("Nobody won")
	screen.set_game_score(player.followers.nb_followers, opponent.followers.nb_followers)
	var theater = Theater.instance()
	theater.set_content(screen)
	get_tree().current_scene.add_child(theater)
