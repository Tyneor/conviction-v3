extends Node2D

onready var slot = $Slot

export var is_for_player = false

func _ready():
	slot.droppable = is_for_player

func add_card(card):
	slot.drop_in(card)

func play_card():
	var card = self.slot.unset_card()
	if card:
		self.slot.droppable = is_for_player
		card.queue_free()

func _on_Slot_card_dropped():
	var card = self.slot.card
	if card:
		self.slot.droppable = false
		card.draggable = false
