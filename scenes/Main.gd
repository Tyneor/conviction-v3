extends Node

const Card = preload("res://scenes/Card.tscn")

onready var player = $Player
onready var opponent = $Opponent
onready var ladder = $Ladder
var personal_opinion = 0

func _ready():
	randomize()
	player.start_set()
	opponent.start_set()

	while true:
		print("player turn")
		yield(player.start_turn(), "completed")
		showdown(true)
		print("opponent turn")
		yield(opponent.start_turn(), "completed")
		showdown(false)

func showdown(is_last_gamer_player):
	var player_card = player.arena.slot.card
	var opponent_card = opponent.arena.slot.card
	if player_card and opponent_card:
		personal_opinion += player_card.number - opponent_card.number
		var new_follower = ladder.set_score(personal_opinion)
		if new_follower:
			personal_opinion = 0
			ladder.set_score(0)
			if new_follower == "player":
				player.add_follower()
			if new_follower == "opponent":
				opponent.add_follower()
		if is_last_gamer_player:
			opponent.arena.delete_card()
		else:
			player.arena.delete_card()
