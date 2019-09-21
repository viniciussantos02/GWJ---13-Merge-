extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var NewPauseState = not get_tree().paused
		get_tree().paused = NewPauseState
		visible = NewPauseState
		
# Main interface buttons
func _on_ResumeButton_pressed():
	visible = not get_tree().paused
	get_tree().paused = false

func _on_RestartButton_pressed():
	owner.get_node("ConfirmRestartInterface/ConfirmRestMenu").visible = true

func _on_QuitButton_pressed():
	owner.get_node("ConfirmQuitInterface/ConfirmQuitMenu").visible = true
	
# Restart buttons	
func _on_YesButton_pressed():
	owner.get_node("PauseMenu").visible = false
	get_tree().paused = false
	return get_tree().reload_current_scene()

func _on_NoButton_pressed():
	owner.get_node("ConfirmRestartInterface/ConfirmRestMenu").visible = false

# Quit Buttons
func _on_YesButtonQuit_pressed():
	get_tree().quit()

func _on_NoButtonQuit_pressed():
	owner.get_node("ConfirmQuitInterface/ConfirmQuitMenu").visible = false