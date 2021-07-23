extends Node2D

var defaultVec2Array : Array
var length = 0 setget set_length
var width = 180 setget set_width
var circle_radius = 100 setget set_circle_radius
var vec2Array = []

func _ready():
	self.defaultVec2Array = [
		Vector2(width / 2, 0), 
		Vector2(width / 2, 0), 
		Vector2(width, 0), 
		Vector2(0, 0), 
		Vector2(- width, 0), 
		Vector2(- width / 2, 0),
		Vector2(- width / 2, 0) 
	]
	
func set_circle_radius(new_circle_radius):
	circle_radius = max(new_circle_radius, 10)
	if self.circle_radius < self.width / 2:
		self.width = self.circle_radius * 2
	self.update()

func set_width(new_width: int):
	width = max(new_width, 20)
	if self.width > self.circle_radius * 2:
		print(self.width, " ", self.circle_radius)
		self.circle_radius = self.width / 2
	self.defaultVec2Array = [
		Vector2(width / 2, 0), 
		Vector2(width / 2, 0), 
		Vector2(width, 0), 
		Vector2(0, 0), 
		Vector2(- width, 0), 
		Vector2(- width / 2, 0),
		Vector2(- width / 2, 0) 
	]
	self.update()

func set_length(new_length: int):
	length = new_length
	self.vec2Array = PoolVector2Array(defaultVec2Array)
	for i in range(1, 6):
		self.vec2Array.set(i, self.vec2Array[i] + Vector2(0, length - sign(length) * width))
	if length != 0:
		self.vec2Array.set(3, Vector2(0, length))
	if abs(length) <= width * 1.5 and abs(length) >= width:
		self.vec2Array.set(2, self.vec2Array[2] + Vector2(abs(length) - 1.5 * width, 0))
		self.vec2Array.set(4, self.vec2Array[4] + Vector2(-abs(length) + 1.5 * width, 0))
	if abs(length) < width:
		self.vec2Array.set(1, Vector2(0, 0))
		self.vec2Array.set(2, Vector2(0.5 * width, 0))
		self.vec2Array.set(4, Vector2(- 0.5 * width, 0))
		self.vec2Array.set(5, Vector2(0, 0))
	self.update()

func _draw():
	draw_polygon(self.vec2Array, PoolColorArray([Color(1, 1, 1)]), [])
	draw_circle(Vector2(0, 0), self.circle_radius, Color(1, 1, 1))

func _input(event):
	if event is InputEventMouseButton:
		print("click")
		self.circle_radius -= 10
	elif event is InputEventMouseMotion:
		print("motion")
#		self.width = (event.position - self.position).x
		self.length = (event.position - self.position).y
