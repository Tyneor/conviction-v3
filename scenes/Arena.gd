extends Node2D

onready var slot = $Slot

func _ready():
	slot.droppable = true
