extends CenterContainer

const Card = preload("res://scenes/Card.tscn")

onready var slot = $Slot
var cards : Array = []

func add_card(card):
	if slot.card == null:
		slot.card = card
	else:
		self.cards.append(card)

func draw_card():
	assert(slot.card != null)
	var old_card = slot.drag_off()
	if self.cards.size() > 0:
		slot.card = cards.pop_front()	
	return old_card
