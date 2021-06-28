tool
extends Node2D

export var bar_width = 10
export var bar_height = 20
export var space_between_bars = 2
export (PoolColorArray) var colors = PoolColorArray()
export var radius = 20

onready var pivot = $Pivot
onready var bars = $Bars


func _ready():
	
	var angle = PI
	var angle_interval = 2 * PI / MusicManager.definition

	
	for i in MusicManager.definition:
		var area = Area2D.new()
		
		var sprite = Sprite.new()
		sprite.texture = preload("res://assets/pixel.png")
		sprite.scale = Vector2(bar_width, bar_height)
		area.add_child(sprite)
		
		
		var color_a : Color = colors[0]
		var color_b : Color = colors[1]
		
		var interpolated_color = Color()
		
		var t = float(i) / MusicManager.definition
		
		interpolated_color.r = color_a.r + (color_b.r - color_a.r) * t
		interpolated_color.g = color_a.g + (color_b.g - color_a.g) * t
		interpolated_color.b = color_a.b + (color_b.b - color_a.b) * t
		
		sprite.modulate = interpolated_color
		
		var collision_shape = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		shape.extents = Vector2(bar_width, bar_height) / 2
		collision_shape.shape = shape
		area.add_child(collision_shape)
		bars.add_child(area)
		
		
		var normal = Vector2(0, -1).rotated(angle)
		var start_pos = (normal * radius)
		area.position = start_pos
		area.look_at(area.global_position - normal)
		area.rotation_degrees += 90
		angle += angle_interval
		
	

func _physics_process(delta):
	
	if Engine.is_editor_hint():
		return
		
	
	for i in range(bars.get_child_count()):
		var bar = bars.get_child(i)
		
		var force = MusicManager.histogram[i]
		var push_force = 2
		
		bar.position = Vector2(0, 1).rotated(bar.rotation) * (MusicManager.histogram[i] + radius * 0.01) * 100 
		
		if MusicManager.histogram[i] < 0.1:
			pass
			#bar.position.y = 0
		
