extends Resource
class_name DragStore

var dragged_card = null
var slots = []

func add_slot(slot):
	if not slots.has(slot):
		slots.append(slot)
	
func remove_slot(slot):
	slots.erase(slot)

func drag(card):
	dragged_card = card

func drop():
	var new_slot
	for slot in slots:
		if slot.is_in_drop_range(dragged_card):
			new_slot = slot
			break
	var old_slot = dragged_card.get_parent()
	old_slot.drag_off()
	var duration = 0
	if new_slot and new_slot != old_slot:
		if new_slot.card:
			duration = old_slot.drop_in(new_slot.drag_off())
		duration = new_slot.drop_in(dragged_card)
	else:
		duration = old_slot.drop_in(dragged_card)
	dragged_card = null
	return duration
