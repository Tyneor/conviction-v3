extends Orator

func start_turn():
	self.play_random_card()
	yield(.start_turn(), "completed")

func play_random_card():
	yield(get_tree().create_timer(1.0), "timeout")
	if arena.slot.card == null:
		var card = hand.get_random_card()
		if card:
			arena.add_card(card)
