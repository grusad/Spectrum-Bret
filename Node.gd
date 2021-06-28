extends Node

var child = null

func _ready():
	child = load("res://src/obsticles/Laser.tscn").instance()
	child.position = Vector2(10, 10)
	add_child(child)

func _process(delta):
	print(child)
	if child:
		child.queue_free()
