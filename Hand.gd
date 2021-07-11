extends Node2D

const DragStore = preload("res://DragStore.tres")
const Card = preload("res://Card.tscn")
const Slot = preload("res://Slot.gd")

var dragged_card = null
onready var slot_container = $SlotContainer

func _ready():
	randomize()
	init_hand()

func init_hand():
	var slots = slot_container.get_children()
	for slot in slots:
#		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		var card = Card.instance()
		card.number = randi() % 10
		slot.card = card
