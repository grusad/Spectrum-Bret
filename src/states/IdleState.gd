extends State

var deacceleration_friction = 6

func enter_state(parent, previous_state):
	.enter_state(parent, previous_state)
	
func exit_state():
	.exit_state()
	
func physics_process(delta):
	.physics_process(delta)
	if parent.get_input_direction().length() > 0:
		transition_to(parent.get_state("MoveState"))
	if Input.is_action_just_pressed("jump"):
		transition_to(parent.get_state("JumpState"))
	if Input.is_action_just_pressed("fire"):
		add_state_as_root(parent.get_state("LaserBeamState"))
		
	parent.apply_horizontal_friction(deacceleration_friction, delta)

	
