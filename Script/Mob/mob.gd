extends Entity
class_name Mob 

@onready var animation_mob = $AnimationPlayer

@export var player_ref: Player

func _ready() -> void:
	$Area3D.connect("body_entered", _on_attack_range_body_entered)
	
func update_animation() -> void:
	if not animation_mob:
		return

func _on_attack_range_body_entered(body: Node) -> void:
	if body == player_ref:
		print("Player hit!")
		


func _physics_process(delta: float) -> void:
	
	apply_movement(delta)
	move_and_slide()

func apply_movement(delta: float) -> void:
	if not player_ref:
		return

	var player_pos = player_ref.global_transform.origin
	var mob_pos = global_transform.origin
			
			# Pour debug
	print("Position du mob: ", mob_pos)
	print("Position du joueur: ", player_pos)
			
	direction = (player_pos - mob_pos).normalized()
			
	if direction != Vector3.ZERO:
					# Utiliser SPD de Entity
		velocity.x = direction.x * SPD
		velocity.z = direction.z * SPD
		print("Velocity appliquée: ", velocity)
	else:
		velocity.x = move_toward(velocity.x, 0, SPD)
		velocity.z = move_toward(velocity.z, 0, SPD)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
