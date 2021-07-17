extends CenterContainer

onready var slot = $Slot
var cards := [] setget set_cards

func set_cards(new_cards : Array):
	assert(self.cards.size() == 0)
	for card in new_cards:
		self.add_card(card)
	
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
