extends Orator

func start_turn():
	self.arena.slot.droppable = true
	yield(.start_turn(), "completed")
