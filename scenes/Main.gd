extends Node

const Card = preload("res://scenes/Card.tscn")

onready var player = $Player
onready var opponent = $Opponent
onready var label = $Label
var personal_opinion = 0
var last_personal_opinion_change = 0

func _ready():
	randomize()
	player.start_game()
	opponent.start_game()

	while true:
		print("player turn")
		yield(player.start_turn(), "completed")
		showdown(true)
		print("opponent turn")
		yield(opponent.start_turn(), "completed")
		showdown(false)

func showdown(is_last_gamer_player):
	var player_card = player.player_arena.slot.card
	var opponent_card = opponent.opponent_arena.slot.card
	if player_card and opponent_card:
		last_personal_opinion_change = player_card.number - opponent_card.number
		personal_opinion += last_personal_opinion_change
		label.text = "PO: {personal_opinion}\nLast change: {last_personal_opinion_change}".format({
			"personal_opinion": personal_opinion, 
			"last_personal_opinion_change": last_personal_opinion_change
		})
		yield(get_tree().create_timer(1.0), "timeout")
		if is_last_gamer_player:
			opponent.opponent_arena.delete_card()
		else:
			player.player_arena.delete_card()
