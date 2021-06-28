extends Line2D

var initial_direction = Vector2.ZERO
var speed = 50

func _ready():
	
	initial_direction = Vector2(1, 0)
	points = [position, position]

func _physics_process(delta):
	points[1].x += speed * delta
