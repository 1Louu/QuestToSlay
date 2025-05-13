extends Entity
class_name Mob 

@export var JUMP_VELOCITY = 4.5
@export var player: Node3D 
@export var HP = 5

func _ready() -> void:
	$Area3D.connect("body_entered", _on_attack_range_body_entered)
	pass 
	

func _on_attack_range_body_entered(body: Node) -> void:
	if body == player:
		print("Player hit!")
		


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player:
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

	move_and_slide()
