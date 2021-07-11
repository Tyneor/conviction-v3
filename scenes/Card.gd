extends Area2D

const DragStore = preload("res://stores/DragStore.tres")

var number = 1
var grabbed_offset : Vector2
var draggable = false

func _ready():
	$Label.text = str(number)
	
func _input(_event):
	if DragStore.dragged_card == self:
		self.global_position = get_global_mouse_position() + self.grabbed_offset

func _on_Card_input_event(_viewport, event, _shape_idx):
	if draggable && event.is_action_pressed("ui_touch") and DragStore.dragged_card == null:
		DragStore.drag(self)
		self.z_index = 2
		self.grabbed_offset = self.global_position - get_global_mouse_position()
#		get_tree().set_input_as_handled()
		
	if event.is_action_released("ui_touch") and DragStore.dragged_card == self:
		DragStore.drop()
		self.z_index = 1
