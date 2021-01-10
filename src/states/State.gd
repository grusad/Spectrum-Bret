extends Node
class_name State

var parent = null
var previous_state = null


func enter_state(parent, previou_state):
	self.parent = parent
	self.previous_state = previous_state
	print(self.name)

func exit_state():
	pass
	
func physics_process(delta):
	pass
	
func transition_to(new_state):
	exit_state()
	new_state.enter_state(parent, self)
	parent.states.erase(self)
	parent.push_state(new_state)

# can combine states to be processed paralell
func combine_with(new_state):
	new_state.enter_state(parent, self)
	parent.push_state(new_state)
