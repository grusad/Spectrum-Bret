extends Line2D

onready var tween = $Tween

func _ready():
	tween.interpolate_property(self, "width", width, 0, 0.2, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.connect("tween_completed", self, "on_tween_completed")
	
func init(width, color):
	self.width = width
	gradient.set_color(0, Color(color.r, color.g, color.b, 0.2))
	gradient.set_color(1, color)
	
func remove():
	tween.start()

func on_tween_completed(object, key):
	queue_free()
	
