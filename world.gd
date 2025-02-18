extends Node3D

@export var Player : CharacterBody3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _get_Player()-> CharacterBody3D:
	return Player
