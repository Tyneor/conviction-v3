extends Resource
class_name DragStore

var dragged_card = null
var slots = []

func add_slot(slot):
	slots.append(slot)

func drag(card):
	dragged_card = card

func drop():
	var new_slot = null
	for slot in slots:
		if slot.is_in_drop_range(dragged_card):
			new_slot = slot
			break

	var old_slot = dragged_card.get_parent()
	old_slot.unset_card()
	
	if new_slot and new_slot != old_slot:
		if new_slot.card:
			old_slot.drop_in(new_slot.unset_card())
		new_slot.drop_in(dragged_card)
	else:
		old_slot.drop_in(dragged_card)
	dragged_card = null
