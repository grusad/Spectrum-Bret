extends State

var jump_force = 1000

func enter_state(parent, previous_state):
	.enter_state(parent, previous_state)
	parent.apply_force(Vector2.UP, jump_force)
	
func physics_process(delta):
	if parent.velocity.y > 0:
		transition_to(parent.get_state("FallState"))
	
