class_name Card extends Area2D
func get_class(): return "Card"

const DragStore = preload("res://stores/DragStore.tres")

var grabbed_offset : Vector2
var draggable := false
var label := "Card" setget set_label

func set_label(new_label):
	label = new_label
	# TODO : set _on_enter_tree because not changed
	if get_node_or_null("TextureRect/Label"):
		$TextureRect/Label.text = self.label
	
func _input(_event):
	if DragStore.dragged_card == self:
		self.global_position = get_global_mouse_position() + self.grabbed_offset

func compare_with(other_card):
	assert(self.get_class() != "Card" and other_card.get_class() != "Card", "Card is an abstract class that can't be compared")

func play_draw_animation(duration=1, flip_card=true):
	if flip_card:
		$AnimationPlayer.play("Draw")
	else:
		$AnimationPlayer.play("DrawWithoutFlip")
	if duration > 0:
		$AnimationPlayer.playback_speed = 1 / duration
	else:
		pass
#		$AnimationPlayer.advance(1)
	yield($AnimationPlayer, "animation_finished")

func play_reveal_animation(duration=1):
	if duration > 0:
		$AnimationPlayer.playback_speed = 1 / duration
	$AnimationPlayer.play("Reveal")
	yield($AnimationPlayer, "animation_finished")
		
func _on_Card_input_event(_viewport, event, _shape_idx):
	if draggable && event.is_action_pressed("ui_touch") and DragStore.dragged_card == null:
		DragStore.drag(self)
		self.z_index = 1
		self.grabbed_offset = self.global_position - get_global_mouse_position()
#		get_tree().set_input_as_handled()
		
	if event.is_action_released("ui_touch") and DragStore.dragged_card == self:
		var duration = DragStore.drop()
		yield(get_tree().create_timer(duration), "timeout")
		self.z_index = 0
