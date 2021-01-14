extends KinematicBody2D
class_name KinematicEntity

var velocity = Vector2()
var states = [] setget push_state

func _ready():
	pass

func _physics_process(delta):
	
	for state in states:
		state.physics_process(delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
func _process(delta):
	for state in states:
		state.process(delta)

func apply_movement(direction, acceleration, max_move_speed, delta):
	velocity = lerp(velocity, direction * max_move_speed, acceleration * delta)

func apply_horizontal_movement(input_direction, acceleration, max_move_speed, delta):
	velocity.x = lerp(velocity.x, input_direction.x * max_move_speed, acceleration * delta)
	
func apply_horizontal_friction(friction, delta):
	velocity.x = lerp(velocity.x, 0, friction * delta)
	
func apply_friction(friction, delta):
	velocity = lerp(velocity, Vector2.ZERO, friction * delta)

func apply_force(direction, force):
	velocity = direction * force

func get_input_direction():
	return Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			0)
	
	
func get_state(state_name):
	return get_node("States/" + state_name)
	
func push_state(state):
	if has_state(state):
		return
	states.push_back(state)

#does root state exist?
func has_state(state):
	if typeof(state) == TYPE_STRING:
		return states.has(get_state(state))
	return states.has(state)

#does state exists in hirarchy (children included)
func has_state_deep(lookup):
	if states.has(lookup):
		return true
	
	for state in states:
		if state.has_child_state(lookup):
			return true
			
	return false	
	

	
