tool
extends Node2D

onready var spectrum = AudioServer.get_bus_effect_instance(1, 0)
onready var audio_stream_player = MasterMusic

export var definition = 20
export var bar_width = 4
export var space_between_bars = 2
export (PoolColorArray) var colors = PoolColorArray()
var total_h = 250
var total_w = 400

var min_freq = 20
var max_freq = 20000
var max_db = 0
var min_db = -40
var accel = 20
var histogram = []


func _ready():
	
	max_db += audio_stream_player.volume_db
	min_db += audio_stream_player.volume_db
	
	for i in range(definition):
		histogram.append(0)
	
	for i in definition:
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
	
	process_spectrum_analyzer(delta)
	
	for i in range(get_child_count()):
		var bar = get_child(i)
		
		var force = histogram[i]
		var push_force = 2
		
		bar.position.y = -histogram[i] * 200
		if histogram[i] < 0.1:
			bar.position.y = 0
		
func process_spectrum_analyzer(delta):
	var freq = min_freq
	var interval = (max_freq - min_freq) / definition
	
	for i in range(definition):
		
		var freqrange_low = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_low = freqrange_low * freqrange_low * freqrange_low * freqrange_low
		freqrange_low = lerp(min_freq, max_freq, freqrange_low)
		
		freq += interval
		
		var freqrange_high = float(freq - min_freq) / float(max_freq - min_freq)
		freqrange_high = freqrange_high * freqrange_high * freqrange_high * freqrange_high
		freqrange_high = lerp(min_freq, max_freq, freqrange_high)
		
		var mag = spectrum.get_magnitude_for_frequency_range(freqrange_low, freqrange_high)
		mag = linear2db(mag.length())
		mag = (mag - min_db) / (max_db - min_db)
		
		mag += 0.3 * (freq - min_freq) / (max_freq - min_freq)
		mag = clamp(mag, 0.05, 1)
		
		histogram[i] = lerp(histogram[i], mag, accel * delta)
