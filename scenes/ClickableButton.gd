class_name ClickableButton extends Button

export var down_scaling = 0.9
var tween : Tween
var scaled_down = false

func _ready():
	self.rect_pivot_offset = self.rect_size / 2
	self.tween = Tween.new()
	self.add_child(self.tween)

func rescale_to(scale):
	self.tween.interpolate_property(self, "rect_scale", null, Vector2(scale, scale), 0.05)
	self.tween.start()

func _input(_event):
	if self.get_draw_mode() == BaseButton.DRAW_PRESSED:
		if scaled_down == false:
			scaled_down = true
			self.rescale_to(down_scaling)
	else:
		scaled_down = false
		self.rescale_to(1)
		
func _gui_input(event):
	if event.is_action_pressed("ui_touch"):
		scaled_down = true
		self.rescale_to(down_scaling)
