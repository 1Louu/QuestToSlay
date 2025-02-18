extends Control
signal paused

func _on_resume_button_pressed() -> void:
	PausePlayer();


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Interface/main_menu.tscn");


func _on_quit_button_pressed() -> void:
	get_tree().quit();


func PausePlayer():
	if Global.paused: 
		get_tree().paused = false
		paused.emit()
	else: 
		get_tree().paused = true
		paused.emit()
	Global.Paused()
