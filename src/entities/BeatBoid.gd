extends KinematicEntity

onready var sensors = $Sensors
onready var detectors = $Detectors

func _ready():
	
	add_to_group("Boid")
	
	var initial_state = get_state("AI_BoidMoveState")
	initial_state.enter_state(self, null)
	states.push_back(initial_state)
	
	
func _physics_process(delta):
	update()
	
	
func _draw():
	var angle = PI
	var angle_interval = 2 * PI / MusicManager.definition
	var radius = 50
	var length = 50
	
	for i in range(MusicManager.definition):
		var normal = Vector2(0, -1).rotated(angle)
		var start_pos = normal * radius
		var end_pos = normal * (radius + MusicManager.histogram[i] * length)
		draw_line(start_pos, end_pos, Color.dodgerblue, 4.0, true)
		angle += angle_interval
