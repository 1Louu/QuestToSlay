extends RayCast3D

signal target
signal offTarget
var targbody: mob
@onready var timer = $OffTargetTimer

func _physics_process(delta: float) -> void:
	if is_colliding(): 
		targbody = get_collider()
		if targbody is mob:
			target.emit(targbody)
		if !timer.is_stopped():
			timer.stop()
	elif timer.is_stopped():
		timer.start(1)
	


func _on_off_target_timer_timeout() -> void:
	offTarget.emit()
