extends State

var jump_force = 1000

func enter_state(parent, previous_state):
	.enter_state(parent, previous_state)
	
func physics_process(delta):
	if parent.is_on_floor():
		transition_to(parent.get_state("IdleState"))
	
