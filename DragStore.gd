extends Resource
class_name DragStore

var dragged_card = null
var slots = []

func drag(card):
	dragged_card = card

func drop():
	var new_slot = null
	for slot in slots:
		if dragged_card in slot.area2D.get_overlapping_areas():
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

func add_slot(slot):
	slots.append(slot)
