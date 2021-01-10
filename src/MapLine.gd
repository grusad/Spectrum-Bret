extends Line2D

func _ready():
	
	for i in points.size():
		var static_body = StaticBody2D.new()	
		var collision_polygon = CollisionPolygon2D.new()
		var collision_points = []
		
		if i == points.size() - 1:
			break
		
		collision_points.push_back(points[i])
		collision_points.push_back(points[i + 1])
		
		collision_polygon.polygon = collision_points
		static_body.add_child(collision_polygon)
		add_child(static_body)
	
		var particles = load("res://src/MapLineParticles.tscn").instance()
		static_body.add_child(particles)
		particles.position = (points[i] + points[i + 1]) * 0.5
		particles.process_material = particles.process_material.duplicate()
		particles.process_material.emission_box_extents.x = points[i].distance_to(points[i + 1]) * 0.5
		particles.look_at(points[i + 1])
		
		
	
	
