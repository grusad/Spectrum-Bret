tool
extends RayCast2D

onready var line = $Line2D
var child = null
var laser_length = 1000

func _ready():
	cast_to = cast_to.rotated(rotation)
	line.points = [Vector2(0, 0), cast_to]

	rotation_degrees = 0

func _process(delta):
	
	if Engine.is_editor_hint():
		return
	
	if is_colliding():
		line.points[1] = line.to_local(get_collision_point())	
		
		var collider = get_collider()
		if collider:		
			if collider.is_in_group("Mirror"):
				
				if not is_instance_valid(child):

					var reflection = load("res://src/obsticles/Laser.tscn").instance()
					add_child(reflection)
					reflection.add_exception(collider)
					child = reflection
					
				if is_instance_valid(child):
					child.position = to_local(get_collision_point())
					child.cast_to = (child.position.normalized().reflect(get_collision_normal()).normalized()) * -laser_length
					var child_points = child.get_node("Line2D").points
					child_points[0].direction_to(child.cast_to) * laser_length
					child.force_raycast_update()
			else:
				if is_instance_valid(child):
					child.queue_free()	
			
				if collider.is_in_group("Player"):
					print("Hitting player by laser")
						
	else:
		line.points[1] = line.points[0].direction_to(cast_to) * laser_length
		if is_instance_valid(child):
			child.queue_free()		
