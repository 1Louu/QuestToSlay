extends Control
signal paused

func _ready() -> void:
	Global.paused = false

func _on_resume_button_pressed() -> void:
	PausePlayer();

func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://interfaces/mainmenu.tscn");

func _on_quit_button_pressed() -> void:
	get_tree().quit();

func PausePlayer():
	if Global.paused: 
		get_tree().paused = false
		hide()
		paused.emit()
	else: 
		get_tree().paused = true
		show()
		paused.emit()
	Global.Paused()
	
func _input(event: InputEvent):
	if(event.is_action_pressed("pause")):
		PausePlayer()
