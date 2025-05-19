extends Entity
class_name projectile

@export var target:Node3D
@export var hone_range: float = 0


var hone_direction 

func _physics_process(delta: float) -> void:
	apply_movement(delta)
	
	move_and_slide()

func apply_movement(delta: float) -> void:
	if target: 
		hone_direction = global_position- target.position 
		rotate_model_to_direction(hone_direction)

func UpdateHoneRange(range: float) -> void:
	hone_range= range
	
