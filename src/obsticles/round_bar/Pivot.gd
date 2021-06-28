tool
extends Node2D

onready var particles = $Particles2D

func _ready():
	particles.modulate = get_parent().colors[0]

