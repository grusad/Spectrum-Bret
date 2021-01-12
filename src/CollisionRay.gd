extends RayCast2D

signal is_colliding
signal just_collided

onready var parent = get_parent()

var first_collision = false


func _physics_process(delta):
	cast_to = parent.velocity.normalized() * 20
	if is_colliding():
		emit_signal("is_colliding", self)
		if not first_collision:
			emit_signal("just_collided", self)
			first_collision = true
			
	else:
		first_collision = false
	
