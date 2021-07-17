class_name Card extends Area2D
func get_class(): return "Card"

const DragStore = preload("res://stores/DragStore.tres")
const Theater = preload("res://scenes/Theater.tscn")
const CardDetails = preload("res://scenes/cards/CardDetails.tscn")

var draggable := false
var grabbed_offset : Vector2
var has_been_dragged := true
var label := "Card" setget set_label
var description : String setget ,get_description

func set_label(new_label):
	label = new_label
	# TODO : set _on_enter_tree because label not changed
	if get_node_or_null("TextureRect/Label"):
		$TextureRect/Label.text = self.label

func get_description():
	return "Description"
	
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


func _input(event):
	if event is InputEventMouseMotion and DragStore.dragged_card == self:
		self.has_been_dragged = true
		self.global_position = get_global_mouse_position() + self.grabbed_offset

func _on_Card_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("ui_touch"):
		self.has_been_dragged = false
		if draggable && DragStore.dragged_card == null:
			DragStore.drag(self)
			self.z_index = 1
			self.grabbed_offset = self.global_position - get_global_mouse_position()
#		get_tree().set_input_as_handled()
		
	if event.is_action_released("ui_touch"):
		if not self.has_been_dragged:
			self.display_details()
		if DragStore.dragged_card == self:
			var duration = DragStore.drop()
			yield(get_tree().create_timer(duration), "timeout")
			self.z_index = 0

func display_details():
	var theater = Theater.instance()
	var cardDetails = CardDetails.instance()
	cardDetails.set_label(self.label)
	cardDetails.set_description(self.description)
	theater.get_node("CenterContainer").add_child(cardDetails)
	get_tree().current_scene.add_child(theater)
	theater.connect("pressed", theater, "queue_free")
