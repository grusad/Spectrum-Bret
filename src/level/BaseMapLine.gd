extends Line2D
class_name BaseMapLine

export (bool) var emit_particles = true

var collision_shapes = []
var particles = []


func _ready():
	
	for i in points.size() - 1:
		
		var static_body = StaticBody2D.new()
		var collision_shape = CollisionShape2D.new()
		var shape = RectangleShape2D.new()
		
		var point_a : Vector2 = points[i]
		var point_b : Vector2 = points[i + 1]
		
		shape.extents = Vector2(point_a.distance_to(point_b) * 0.5, width * 0.5)
		
		collision_shape.shape = shape
		static_body.add_child(collision_shape)
		static_body.position = (point_a + point_b) * 0.5
		static_body.rotation = (point_a - point_b).angle()
		add_child(static_body)
		
		collision_shapes.push_back(collision_shape)
		
		if emit_particles:
			var particle : Particles2D = load("res://src/level/MapLineParticles.tscn").instance()
			particle.amount = shape.extents.x * 0.1
			
			static_body.add_child(particle)
			particle.process_material = particle.process_material.duplicate()
			particle.process_material.emission_box_extents.x = points[i].distance_to(points[i + 1]) * 0.5
			particle.look_at(points[i + 1])
			particles.push_back(particle)

func set_disable_collision(disabled):
	for shape in collision_shapes:
		shape.disabled = disabled
		
func set_disable_particles(disabled):
	for particle in particles:
		particle.emitting = !disabled
