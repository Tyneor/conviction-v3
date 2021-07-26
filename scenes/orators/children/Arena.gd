extends Control

signal card_played

export var is_for_player = false
onready var slot = $Slot

func add_card(card):
	if not is_for_player:
		card.z_index = 1 # should already be 1 for player anyway
	var duration = slot.drop_in(card)
	if not is_for_player:
		yield(card.play_reveal_animation(duration), "completed")
		card.z_index = 0
		emit_signal("card_played")

func delete_card():
	self.slot.delete_card()
	
func delete_previous_card():
	self.slot.delete_previous_card()

func _on_Slot_card_dropped():
	if is_for_player:
		var card = self.slot.card
		if card:
			self.slot.droppable = false
			card.draggable = false
			emit_signal("card_played")
