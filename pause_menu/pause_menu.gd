extends Control

func _ready() -> void:
	hide()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		print('pause')
		if get_tree().paused:
			resume()
		else:
			pause()

# Resume the game by hiding the pause menu and unpausing the parent node's tree
func resume() -> void:
	hide()
	get_tree().paused = false

# Pause game by showing the menu and pausing the parent node's tree
func pause() -> void:
	show()
	get_tree().paused = true


func _on_continue_button_pressed() -> void:
	resume()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
