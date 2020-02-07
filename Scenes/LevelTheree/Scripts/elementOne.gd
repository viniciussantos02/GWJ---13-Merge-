extends RigidBody2D

var dragging : bool = false
var translate_by = null

func _ready():
	add_to_group(game.RIGHTLVONE)
	
func _integrate_forces(state):
	if dragging:
		state.set_linear_velocity(Vector2(0, 0))
		state.set_angular_velocity(0)
		if translate_by:
			var t = state.get_transform()
			state.set_transform(Transform2D(t.get_rotation(), t.get_origin() + translate_by))
			translate_by = null 