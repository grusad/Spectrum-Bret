extends BaseMapLine

onready var tween = $Tween
onready var initial_width = width
export (int) var histogram_index = 0

func _physics_process(delta):
	var histogram = MusicManager.histogram[histogram_index]
	
	if not tween.is_active():
		
		if(histogram < 0.7):
			tween.interpolate_property(self, "width", width, 0, 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.start()
			set_disable_collision(true)
			set_disable_particles(true)
			
		else:
			tween.interpolate_property(self, "width", width, initial_width, 0.1, Tween.TRANS_EXPO, Tween.EASE_OUT)
			tween.start()
			set_disable_collision(false)
			set_disable_particles(false)
