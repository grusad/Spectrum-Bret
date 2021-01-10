extends State

var jump_force = 1000

func enter_state(parent, previous_state):
	.enter_state(parent, previous_state)
	
func physics_process(delta):
	if parent.velocity.y == 0:
		transition_to(parent.get_state("IdleState"))
	
