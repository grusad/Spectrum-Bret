extends KinematicEntity

onready var aim_pivot = $AimPivot
onready var dash_particles = $DashParticles
onready var camera = $Camera2D

func _ready():
	
	add_to_group("Player")
	
	var initial_state = get_state("IdleState")
	initial_state.enter_state(self, null)
	initial_state.combine_with(get_state("GravityState"))
	states.push_back(initial_state)
