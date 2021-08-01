class_name ClickableArea extends Area2D

signal pressed

export var down_scaling := 0.9
var _tween : Tween
var pressed := false
var scaled_down := false
var draggable := false

func _ready():
	_tween = Tween.new()
	self.add_child(_tween)
	self.connect("mouse_entered", self, "scale_down")
	self.connect("mouse_exited", self, "scale_up")
	self.connect("input_event", self, "_on_input_event")

func rescale_to(scale):
	self._tween.interpolate_property(self, "scale", null, Vector2(scale, scale), 0.05)
	self._tween.start()

func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("ui_touch"):
		pressed = true
		if not scaled_down:
			scaled_down = true
			self.rescale_to(down_scaling)
		
func _input(event : InputEvent):
	if event.is_action_released("ui_touch"):
		pressed = false
		if scaled_down:
			emit_signal("pressed")
			scaled_down = false
			self.rescale_to(1)
	
func scale_down():
	if pressed and not scaled_down:
		scaled_down = true
		self.rescale_to(down_scaling)

func scale_up():
	if scaled_down and not draggable:
		scaled_down = false
		self.rescale_to(1)

