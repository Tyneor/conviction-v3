extends CenterContainer

const Theater = preload("res://scenes/Theater.tscn")
const DeckDetails = preload("res://scenes/orators/children/DeckDetails.tscn")

export var is_for_player = false
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

func display_details():
	var deckDetails = DeckDetails.instance()
	deckDetails.set_label(
		self.cards.size() + (1 if slot.card else 0), 
		is_for_player)
	var theater = Theater.instance()
	theater.set_content(deckDetails)
	get_tree().current_scene.add_child(theater)
