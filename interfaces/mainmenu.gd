extends Control

func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://World.tscn")


func _on_button_quit_pressed() -> void:
	get_tree().quit()
