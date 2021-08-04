extends Orator

func start_turn(max_duration=5):
	self.arena.slot.droppable = true
	yield(.start_turn(max_duration), "completed")
