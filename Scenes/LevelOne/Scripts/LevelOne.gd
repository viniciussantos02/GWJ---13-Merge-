extends Node

onready var recipientOne = $RecipientOne
onready var recipientTwo = $RecipientTwo
var merge_particle = preload("res://Scenes/LevelOne/Particles2D.tscn")
var interface_result = preload("res://Interfaces/InterfaceResult.tscn")

var haveElement1 : bool
var haveElement2 : bool

var winning : bool

var shape = null

# Check function
func _on_MergeButton_pressed():
	merge_check()

func merging():
	var p = merge_particle.instance()
	add_child(p)

func _on_Anime_animation_finished(anim_name):
	if anim_name == "Merge":
		var w = interface_result.instance()
		add_child(w)
		w.show_result(winning)

# Signals
func _on_RecipientOne_haveElement():
	haveElement1 = true
	$Anime.stop()
	$NoElements.visible = false

func _on_RecipientTwo_haveElement():
	haveElement2 = true
	$Anime.stop()
	$NoElements.visible = false

func _on_RecipientOne_haveNoElement():
	haveElement1 = false
	
func _on_RecipientTwo_haveNoElement():
	haveElement2 = false
	
# Start the drag-and-drop thing
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			shape = find_colliding_shape(event.position)
			if shape == null:
				return
			shape.dragging = true
		elif shape != null:
			shape.dragging = false
			shape.apply_impulse(Vector2(0, 0), Vector2(0, 1))
			for node in get_node("Elements").get_children():
				node.set_sleeping(false)
			shape = null
	elif event is InputEventMouseMotion && shape != null:
		if shape.translate_by == null:
			shape.translate_by = Vector2(0, 0)
		shape.translate_by += event.get_relative()
		for node in get_node("Elements").get_children():
			node.set_sleeping(false)
	
func find_colliding_shape(pos):
	var pointer = get_node("Pointer")
	pointer.set_position(pos)
	var pointerShape = pointer.shape_owner_get_shape(0, 0)
	var pointerTransform = pointer.get_transform()
	for node in get_node("Elements").get_children():
		var shape = node.shape_owner_get_shape(0, 0)
		var res = shape.collide(node.get_transform(), pointerShape, pointerTransform)
		if res:
			return node
	return null

func _on_TextureButton_pressed():
	$Instructions/InstructionsInterface.visible = true

func _on_OKButton_pressed():
	$Instructions/InstructionsInterface.visible = false
	
func merge_check():
	if haveElement1 and haveElement2:
		if recipientOne.elementOne.is_in_group(game.RIGHTLVONE) && recipientTwo.elementTwo.is_in_group(game.RIGHTLVONE):
			$Anime.play("Merge")
			winning = true
			merging()
			$Elements/elementOne.queue_free()
			$Elements/elementTwo.queue_free()
			$Elements/elementThree.queue_free()
			$MergeButton.disabled = true
			$BookButton.disabled = true
		else:
			$Anime.play("Merge")
			winning = false
			merging()
			$Elements/elementOne.queue_free()
			$Elements/elementTwo.queue_free()
			$Elements/elementThree.queue_free()
			$MergeButton.disabled = true
			$BookButton.disabled = true
	else:
		$Anime.play("NoElementsAnime")

