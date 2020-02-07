extends Sprite

signal haveElement
signal haveNoElement
var elementTwo

func _on_ElementTwoArea_body_entered(body):
	emit_signal('haveElement')
	elementTwo = body

func _on_ElementTwoArea_body_exited(body):
	emit_signal("haveNoElement")
