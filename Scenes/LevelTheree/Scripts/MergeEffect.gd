extends Particles2D


func _ready():
	var t = Tween.new()
	t.interpolate_property(self, 'speed_scale', 0, 1, 5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	add_child(t)
	t.start()
	
	var t2 = Tween.new()
	t2.interpolate_property(self, 'scale', Vector2(.2,.2), Vector2(1,1), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	add_child(t2)
	t2.start()
	