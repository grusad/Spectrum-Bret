extends State

const MAX_FALL_SPEED = 1200

var gravity = 50

func enter_state(parent, previous_state):
	.enter_state(parent, previous_state)

func physics_process(delta):
	parent.velocity.y += gravity
	
	
