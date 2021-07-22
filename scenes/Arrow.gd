extends Node2D

onready var polygon2D = $Polygon2D
var defaultSize : PoolVector2Array
var size = 0 setget set_size

func _ready():
	defaultSize = polygon2D.polygon

func set_size(new_size: int):
	var new_polygon = polygon2D.polygon
	for i in range(2, 7):
		new_polygon.set(i, defaultSize[i] + Vector2(0, new_size - sign(new_size) * 50))
	if new_size < 0:
		new_polygon.set(4, Vector2(new_polygon[4].x, new_polygon[4].y - 100))
	if new_size == 0:
		new_polygon.set(4, Vector2(0, 0))
	if abs(new_size) < 50:
		print("moins 50")
		new_polygon.set(2, Vector2(0, 0))
		new_polygon.set(3, Vector2(abs(new_size) + 5, 0))
		new_polygon.set(4, Vector2(new_polygon[4].x, new_polygon[4].y))
		new_polygon.set(5, Vector2(- abs(new_size) - 5, 0))
		new_polygon.set(6, Vector2(0, 0))
	polygon2D.polygon = new_polygon
	size = new_size

func _input(event):
	if event is InputEventMouseMotion:
		self.size = (event.position - self.position).y
