extends Node2D

var length = 200 setget set_length
var width = 70 setget set_width
var circle_radius = 50 setget set_circle_radius
var vec2_array = []

func _ready():
	self._calculate_vec2_array()

func set_circle_radius(new_circle_radius):
	if max(new_circle_radius, 20) != self.circle_radius:
		circle_radius = max(new_circle_radius, 10)
		if self.circle_radius < self.width / 2:
			self.width = self.circle_radius * 2
		self._calculate_vec2_array()

func set_width(new_width: int):
	if max(new_width, 20) != self.width:
		width = max(new_width, 20)
		if self.width > self.circle_radius * 2:
			print(self.width, " ", self.circle_radius)
			self.circle_radius = self.width / 2
		self._calculate_vec2_array()

func set_length(new_length: int):
	if new_length != self.length:
		length = new_length
		self._calculate_vec2_array()
	
func _calculate_vec2_array():
	self.vec2_array = PoolVector2Array([
		Vector2(width / 2, 0), 
		Vector2(width / 2, length - sign(length) * width), 
		Vector2(width, length - sign(length) * width), 
		Vector2(0, length), 
		Vector2(- width, length - sign(length) * width), 
		Vector2(- width / 2, length - sign(length) * width),
		Vector2(- width / 2, 0) 
	])
	if length == 0:
		self.vec2_array.set(3, Vector2(0, 0))
	if abs(length) <= width * 1.5:
		self.vec2_array.set(2, Vector2(max(0.5 * width, abs(length) - 0.5 * width), self.vec2_array[2].y))
		self.vec2_array.set(4, Vector2(- max(0.5 * width, abs(length) - 0.5 * width), self.vec2_array[4].y))
	if abs(length) <= width:
		self.vec2_array.remove(5)
		self.vec2_array.remove(4)
		self.vec2_array.remove(2)
		self.vec2_array.remove(1)
	self.update()

func _draw():
	draw_polygon(self.vec2_array, PoolColorArray(), [])
	draw_circle(Vector2(0, 0), self.circle_radius, Color(1, 1, 1))

func _input(event):
	if event is InputEventMouseButton:
		print("click")
		self.circle_radius -= 10
	elif event is InputEventMouseMotion:
		print("motion")
#		self.width = (event.position - self.position).x
		self.length = (event.position - self.position).y
