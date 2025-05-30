extends Entity
class_name projectile

@export var homing_range: float = 0
@export var magic_cost: float = 0

var target: Entity
var homing_direction 

func _physics_process(delta: float) -> void:
	apply_movement(delta)
	move_and_slide()

func apply_movement(delta: float) -> void:
	if target: 
		look_at(target.global_position)
	var global_direction = (transform.basis * Vector3(direction.x, 0, direction.z)).normalized()
	velocity.z = lerp(velocity.z, global_direction.z * SPD, ACCELERATION * delta)

func UpdateHomingRange(range: float) -> void:
	homing_range= range

func _on_homing_area_3d_body_entered(body: Node3D) -> void:
	if(body is Entity and !target):
		target = body

func _on_hurt_area_3d_body_entered(body: Node3D) -> void:
	if(body is Entity): 
		body.take_damage(Strenght)
	queue_free()
