extends RayCast3D

signal target
var targbody

func _physics_process(delta: float) -> void:
	if is_colliding(): 
		targbody = get_collider()
		target.emit()
