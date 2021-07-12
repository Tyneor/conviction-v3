extends Node

const Card = preload("res://scenes/Card.tscn")

onready var player = $Player
onready var opponent = $Opponent

func _ready():
	randomize()
	player.init_deck()
	opponent.init_deck()

	while true:
		yield(start_player_turn(), "completed")
		yield(start_opponent_turn(), "completed")

func start_player_turn():
	yield($Player, "end_turn")

func start_opponent_turn():
	yield($Opponent, "end_turn")
			
