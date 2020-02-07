extends Sprite

signal haveElement
signal haveNoElement
var elementOne

func _on_ElementOneArea_body_entered(body):
	emit_signal('haveElement')
	elementOne = body

func _on_ElementOneArea_body_exited(body):
	emit_signal("haveNoElement")