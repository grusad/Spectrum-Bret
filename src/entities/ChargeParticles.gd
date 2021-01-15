extends Particles2D

func _physics_process(delta):
	self.speed_scale =  (1 / Engine.time_scale) * 4
