extends CharacterBody3D
class_name Entity

@export var MaxHP: float 
@export var CurrentHP: float  
@export var Strenght: float

@export var MaxMana: float
@export var Mana: float

@export var SPD: float
@export var JUMP_VELOCITY: float
@export var armor: float
@export var Entityname:String  

@export var ROTATION_SPEED = 5

var direction: Vector3 = Vector3.ZERO 
# Direction serve as a point to look at (mostly used for mobs),  
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready(): 
	CurrentHP = MaxHP

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	apply_movement(delta)
	
	move_and_slide()
	
	update_animation()


func rotate_model_to_direction(delta: float) -> void:
	if direction != Vector3.ZERO:
		var target_rotation = atan2(direction.x, direction.z)
		var current_rotation = rotation.y
		rotation.y = lerp_angle(current_rotation, target_rotation, ROTATION_SPEED * delta)

func apply_movement(delta: float) -> void:
	pass

func update_animation() -> void:
	pass
	
func take_damage(amount: float) -> void:
	CurrentHP -= amount
	if CurrentHP <= 0:
		CurrentHP = 0
		die()
		
func heal(amount: float) -> void:
	CurrentHP = min(CurrentHP + amount, MaxHP)
	
func die() -> void:
	pass 
