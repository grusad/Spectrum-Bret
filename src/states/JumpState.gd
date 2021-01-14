extends State

var jump_force = 1000
var acceleration = 6
var max_air_speed = 500
var max_dash = 1
var current_dash = 0

func enter_state(parent, previous_state):
	.enter_state(parent, previous_state)
	parent.apply_force(Vector2.UP, jump_force)
	
func exit_state():
	.exit_state()
	current_dash = 0
	
func physics_process(delta):
	.physics_process(delta)
	if not has_child_state(parent.get_state("DashState")):
		var input_direction = parent.get_input_direction()
		if input_direction.x != 0:
			parent.apply_horizontal_movement(input_direction, acceleration, max_air_speed, delta)
	
	#To not catch the initial jump event
	yield(get_tree(), "physics_frame")
	
	if Input.is_action_just_pressed("jump") and current_dash < max_dash:
		current_dash += 1
		combine_with(parent.get_state("DashState"))
		
	if parent.is_on_floor():
		transition_to(parent.get_state("IdleState"))
		
	
