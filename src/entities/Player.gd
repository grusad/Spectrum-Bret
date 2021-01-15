extends KinematicEntity

onready var aim_pivot = $AimPivot
onready var dash_particles = $DashParticles
onready var camera = $Camera2D
onready var aim_ray = $AimPivot/RayCast2D
onready var charge_particles = $ChargeParticles

func _ready():
	
	add_to_group("Player")
	
	var initial_state = get_state("IdleState")
	initial_state.enter_state(self, null)
	var gravity_state = get_state("GravityState")
	gravity_state.enter_state(self, null)
	states.push_back(gravity_state)
	states.push_back(initial_state)
	
