extends KinematicBody2D

onready var aim_pivot = $AimPivot

var velocity = Vector2()
var states = [] setget push_state

func _ready():
	var initial_state = get_state("IdleState")
	initial_state.enter_state(self, null)
	initial_state.combine_with(get_state("GravityState"))
	states.push_back(initial_state)

func _physics_process(delta):
	
	for state in states:
		state.physics_process(delta)	

	velocity = move_and_slide(velocity, Vector2.UP)
	
func _process(delta):
	for state in states:
		state.process(delta)

func apply_horizontal_movement(input_direction, acceleration, max_walk_speed, delta):
	velocity.x = lerp(velocity.x, input_direction.x * max_walk_speed, acceleration * delta)
	
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
	
func has_state(state):
	if typeof(state) == TYPE_STRING:
		return states.has(get_state(state))
	return states.has(state)
	

	
