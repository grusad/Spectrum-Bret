extends State

var deacceleration_friction = 0.4

func enter_state(parent, previous_state):
	.enter_state(parent, previous_state)
	
func physics_process(delta):
	
	if parent.get_input_direction().length() > 0:
		transition_to(parent.get_state("MoveState"))
	if Input.is_action_just_pressed("jump"):
		combine_with(parent.get_state("JumpState"))
		
	parent.apply_horizontal_friction(deacceleration_friction)

	