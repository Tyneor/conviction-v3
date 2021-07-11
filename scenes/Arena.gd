extends Node2D

onready var slot = $Slot

export var is_for_player = false

func _ready():
	if is_for_player:
		slot.droppable = true
