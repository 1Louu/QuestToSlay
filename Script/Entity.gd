extends CharacterBody3D
class_name Entity

@export var Entityname:String  = "Default"
@export_group("Entity Combat Stats")
@export var MaxHP: float = 5
var CurrentHP: float  
@export var Strenght:  = 1
@export var MaxMana: float = 1 
@export var Mana: float =1 
@export var armor: float=1

@export_group("Entity Movement Stats")
@export var SPD: float
@export var JUMP_VELOCITY: float
@export var ACCELERATION = 5
@export var ROTATION_SPEED = 5

var direction: Vector3 = Vector3.ZERO 
# Direction serve as a point to look at (mostly used for mobs),  
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready(): 
	CurrentHP = MaxHP

func _physics_process(delta):
	apply_movement(delta)
	move_and_slide()
	update_animation()


func rotate_model_to_direction(delta: float) -> void:
	if direction != Vector3.ZERO:
		var target_rotation = atan2(direction.x, direction.z)
		var current_rotation = rotation.y
		rotation.y = lerp_angle(current_rotation, target_rotation, ROTATION_SPEED * delta)
		
func apply_movement(delta: float) -> void:
	var global_direction = (transform.basis * Vector3(direction.x, 0, direction.z)).normalized()
	velocity.x = lerp(velocity.x, global_direction.x * SPD, ACCELERATION * delta)
	velocity.z = lerp(velocity.z, global_direction.z * SPD, ACCELERATION * delta)
	
	if not is_on_floor():
		velocity.y -= gravity * delta

func update_animation() -> void:
	pass
	
func take_damage(amount: float) -> void:
	CurrentHP -= amount
	print("damage taken ! Hit : %d", amount)
	if CurrentHP <= 0:
		CurrentHP = 0
		die()
		
func heal(amount: float) -> void:
	CurrentHP = min(CurrentHP + amount, MaxHP)
	
func die() -> void:
	pass 
