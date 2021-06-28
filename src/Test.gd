extends Node2D

var asset = preload("res://assets/glowing_circle.png")

func _ready():
	for x in 100:
		for y in 100:
			var sprite = Sprite.new()
			sprite.texture = asset
			add_child(sprite)
			sprite.position = Vector2(x, y)
		
