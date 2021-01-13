tool
extends Node2D

export var bar_width = 4
export var space_between_bars = 2
export (PoolColorArray) var colors = PoolColorArray()

var total_h = 250
var total_w = 400


func _ready():
	
	for i in MusicManager.definition:
		var area = Area2D.new()
		var polygon = Polygon2D.new()
		var polygon_array = [
			Vector2(0, 0),
			Vector2(bar_width, 0),
			Vector2(bar_width, 200),
			Vector2(0, 200)
		]
		polygon.polygon = polygon_array
		
		
		var color_a : Color = colors[0]
		var color_b : Color = colors[1]
		
		var interpolated_color = Color()
		
		var t = float(i) / 40
		
		interpolated_color.r = color_a.r + (color_b.r - color_a.r) * t
		interpolated_color.g = color_a.g + (color_b.g - color_a.g) * t
		interpolated_color.b = color_a.b + (color_b.b - color_a.b) * t
		
		polygon.color = interpolated_color
		
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.polygon = polygon_array
		area.add_child(collision_polygon)
		area.add_child(polygon)	
		add_child(area)
		area.position.x = i * space_between_bars * bar_width
	
	
	for child in get_children():
		child.connect("body_entered", self, "on_body_entered")

func on_body_entered(body):
	pass

func _physics_process(delta):
	
	if Engine.is_editor_hint():
		return
	
	for i in range(get_child_count()):
		var bar = get_child(i)
		
		var force = MusicManager.histogram[i]
		var push_force = 2
		
		bar.position.y = -MusicManager.histogram[i] * 200
		
		if MusicManager.histogram[i] < 0.1:
			bar.position.y = 0
		
