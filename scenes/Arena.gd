extends Node2D

export var is_for_player = false
signal card_played
onready var slot = $Slot

func add_card(card):
	var duration = slot.drop_in(card)
	if not is_for_player:
		yield(card.play_reveal_animation(duration), "completed")
		emit_signal("card_played")

func delete_card():
	self.slot.delete_card()

func _on_Slot_card_dropped():
	if is_for_player:
		var card = self.slot.card
		if card:
			self.slot.droppable = false
			card.draggable = false
			emit_signal("card_played")
