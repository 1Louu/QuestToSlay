extends Entity
class_name projectile

@export var homing_range: float = 0

var target: Entity
var homing_direction 

func _physics_process(delta: float) -> void:
	apply_movement(delta)

func apply_movement(delta: float) -> void:
	if target: 
		look_at(target.global_position)
	translate(Vector3(0,0, lerp(velocity.z, SPD, ACCELERATION * delta)))

func UpdateHomingRange(r: float) -> void:
	homing_range= r

func _on_homing_area_3d_body_entered(body: Node3D) -> void:
	if(body is Entity and !target):
		target = body

func _on_hurt_area_3d_body_entered(body: Node3D) -> void:
	if(body is Entity): 
		body.take_damage(Strenght)
	queue_free()
