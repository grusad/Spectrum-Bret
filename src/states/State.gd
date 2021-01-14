extends Node
class_name State

var parent = null
var previous_state = null
var child_states = []
var parent_state = null


func enter_state(parent, previous_state):
	self.parent = parent
	self.previous_state = previous_state

func exit_state():
	for child in child_states:
		child.exit_state()
	child_states = []
	if parent_state:
		parent_state.child_states.erase(self)
	
func physics_process(delta):
	for child in child_states:
		child.physics_process(delta)
	
	
func process(delta):
	for child in child_states:
		child.process(delta)
	
func transition_to(new_state):
	exit_state()
	new_state.enter_state(parent, self)
	parent.states.erase(self)
	parent.push_state(new_state)

# can combine states to be processed paralell with parent
func combine_with(new_state):
	new_state.enter_state(parent, null)
	new_state.parent_state = self
	self.child_states.push_back(new_state)
	
	
func remove_state(state):
	state.exit_state()
	parent.states.erase(state)
	
func has_child_state(state):
	return child_states.has(state)
	
