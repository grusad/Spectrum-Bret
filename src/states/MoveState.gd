extends State

var acceleration = 2
var max_walk_speed = 500

func enter_state(parent, previous_state):
	.enter_state(parent, previous_state)
	
func physics_process(delta):
	
	if Input.is_action_just_pressed("jump"):
		transition_to(parent.get_state("JumpState"))
				
	var input_direction = parent.get_input_direction()
	
	if input_direction.x != 0:
		parent.apply_horizontal_movement(input_direction, acceleration, max_walk_speed, delta)
	else:
		transition_to(parent.get_state("IdleState"))
		
