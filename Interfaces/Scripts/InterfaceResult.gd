extends CanvasLayer

func _on_GoButton_pressed():
	return get_tree().change_scene("res://Scenes/LevelTwo/LevelTwo.tscn")
	
func show_result(winner):
	if winner:
		$WinPanel.visible = true
	else:
		$LosePanel.visible = true
		
func _on_RestartButton_pressed():
	return get_tree().reload_current_scene()
