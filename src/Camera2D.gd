extends Camera2D

var default_zoom = zoom;
var amount = 0
var target = 0

var is_zooming = false

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	zoom = lerp(zoom, target, amount)
	if zoom == target:
		set_physics_process(false)

func start_zoom(target, amount):
	self.target = target
	self.amount = amount
	set_physics_process(true)
	

func reset_zoom(amount):
	start_zoom(default_zoom, amount)
