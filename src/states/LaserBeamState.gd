extends State

var has_relase_fire = false
var time_deacceleration = 0.15
var min_time_scale = 0.5
var rotation_speed = 500
var force = 400
var beam_length = 400


func enter_state(parent, previous_state):
	.enter_state(parent, previous_state)
	parent.aim_pivot.visible = true
	parent.aim_pivot.modulate = Color(1, 0, 0)
		

func exit_state():
	.exit_state()
	Engine.time_scale = 1.0
	parent.apply_force(Vector2(-1, 0).rotated(parent.aim_pivot.rotation), force)
	parent.aim_pivot.rotation_degrees = 0
	parent.aim_pivot.visible = false	
	parent.camera.reset_zoom(0.02)
	parent.aim_pivot.modulate = Color(1, 1, 1)
	has_relase_fire = false
	

func physics_process(delta):
	.physics_process(delta)
	if not has_relase_fire:
		Engine.time_scale = lerp(Engine.time_scale, min_time_scale, time_deacceleration)	
		parent.aim_pivot.rotation_degrees += rotation_speed * delta * (1 / Engine.time_scale * 0.5)
		parent.camera.start_zoom(Vector2(0.8, 0.8), 0.02)
	
	if Input.is_action_just_released("fire") and not has_relase_fire:
		
		var dash_state = parent.get_state("DashState")
		if(parent.has_state_deep(dash_state)):
			remove_state(dash_state)
		
		parent.aim_ray.cast_to = Vector2(1, 0) * beam_length
		
		var from_pos = parent.global_position
		var to_pos = from_pos + Vector2(1, 0).rotated(parent.aim_pivot.rotation) * beam_length
		
		var temporary_line = load("res://src/TemporaryLine2D.tscn").instance()
		temporary_line.init(2, Color.rebeccapurple)
		get_tree().root.add_child(temporary_line)
		temporary_line.points = [from_pos, to_pos]
		temporary_line.remove()
		
		remove_state(self)
		
