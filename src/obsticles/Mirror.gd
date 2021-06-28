extends StaticBody2D

onready var tween = $Tween

func _ready():
	randomize()
	add_to_group("Mirror")

func _process(delta):
	var histogram = MusicManager.histogram[10]
	
	if histogram > 0.7 and not tween.is_active():
		tween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotation_degrees + (45 * pow(-1, randi() % 2)), 2, Tween.TRANS_EXPO, Tween.EASE_OUT)
		tween.start()
	
