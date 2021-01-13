extends State

onready var boids = get_tree().get_nodes_in_group("Boid")

var move_speed = 100
var acceleration = 6
var perception_radius = 100

var steer_force = 50.0
var alignment_force = 0.6
var cohesion_force = 0.6
var seperation_force = 0.6
var avoidance_force = 0.6
var direction = Vector2()	

func enter_state(parent, previous_state):
	.enter_state(parent, previous_state)
	
func physics_process(delta):
	var neighbors = get_neighbors(perception_radius)
	
	
	
	direction += (get_tree().get_nodes_in_group("Player")[0].global_position - parent.global_position).normalized() * 2
	direction += process_alignments(neighbors) * alignment_force
	direction += process_cohesion(neighbors) * cohesion_force
	direction += process_seperation(neighbors) * seperation_force

	if is_obsticle_ahead():
		direction += process_obsticle_avoidance() * avoidance_force

	parent.rotation = parent.velocity.angle()
	parent.apply_movement(direction.normalized(), acceleration, move_speed, delta)
	

func process_cohesion(neighbors):
	var vector = Vector2()
	if neighbors.empty():
		return vector
	for boid in neighbors:
		vector += boid.position
	vector /= neighbors.size()
	return steer((vector - parent.position).normalized() * move_speed)
		

func process_alignments(neighbors):
	var vector = Vector2()
	if neighbors.empty():
		return vector
		
	for boid in neighbors:
		vector += boid.velocity
	vector /= neighbors.size()
	return steer(vector.normalized() * move_speed)

func process_seperation(neighbors):
	var vector = Vector2()
	var close_neighbors = []
	for boid in neighbors:
		if parent.position.distance_to(boid.position) < perception_radius / 2:
			close_neighbors.push_back(boid)
	if close_neighbors.empty():
		return vector
	
	for boid in close_neighbors:
		var difference = parent.global_position - boid.global_position
		vector += difference.normalized() / difference.length()
	
	vector /= close_neighbors.size()
	
	return steer(vector.normalized() * move_speed)
	

func steer(var target):
	var steer = target - parent.velocity
	steer = steer.normalized() * steer_force
	return steer
	
func is_obsticle_ahead():
	for ray in parent.detectors.get_children():
		if ray.is_colliding():
			return true
	return false

func process_obsticle_avoidance():
	for ray in parent.sensors.get_children():
		if not ray.is_colliding():
			return steer( (ray.cast_to.rotated(ray.rotation + parent.rotation)).normalized() * move_speed )			
	return Vector2.ZERO

func get_neighbors(view_radius):
	var neighbors = []

	for boid in boids:
		if parent.global_position.distance_to(boid.global_position) <= view_radius and not boid == self:
			neighbors.push_back(boid)
	return neighbors
			
