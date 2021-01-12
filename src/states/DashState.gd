extends State

var time_deacceleration = 0.15
var rotation_speed = 500
var force = 2000
var has_released_dash = false
var deacceleration_friction = 20.0
var dash_time = 0.2
var timer = 0
var temporary_line = null

	

func enter_state(parent, previous_state):
	.enter_state(parent, previous_state)
	parent.aim_pivot.visible = true
	remove_state(parent.get_state("GravityState"))

	
	
func exit_state():
	timer = 0
	has_released_dash = false
	temporary_line.remove()
	temporary_line = null
	combine_with(parent.get_state("GravityState"))

	
func physics_process(delta):
	if not has_released_dash:
		Engine.time_scale = lerp(Engine.time_scale, 0.01, time_deacceleration)	
		parent.aim_pivot.rotation_degrees += rotation_speed * delta * (1 / Engine.time_scale * 0.5)
	
	if Input.is_action_just_released("jump") and not has_released_dash:
		has_released_dash = true
		Engine.time_scale = 1.0
		parent.apply_force(Vector2(1, 0).rotated(parent.aim_pivot.rotation), force)
		parent.aim_pivot.rotation_degrees = 0
		parent.aim_pivot.visible = false
		
		temporary_line = load("res://src/TemporaryLine2D.tscn").instance()
		get_tree().root.add_child(temporary_line)
		temporary_line.points = [parent.global_position, parent.global_position]

	if has_released_dash:
		timer += delta
		
		if parent.is_on_wall() or parent.is_on_ceiling():
			temporary_line.add_point(parent.global_position)
			print("got here")
		
		print(temporary_line.points.size())
		temporary_line.points[temporary_line.points.size() - 1] = parent.global_position	
			
		if timer >= dash_time:
			
			parent.apply_friction(deacceleration_friction, delta)
			
			if(parent.velocity.length() < 0.05):
				remove_state(self)
			
