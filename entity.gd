class_name Entity
extends CharacterBody3D

@export var SPEED = 5.0
@export var ATTACK = 5
@export var DEFENSE = 5
@export var MAX_HP = 5
@export var ROTATION_SPEED = 5

var health: float
var is_alive: bool = true
var direction: Vector3 = Vector3.ZERO
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var model = $Model
@onready var animation_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = MAX_HP

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
	health -= amount
	if health <= 0 and is_alive:
		health = 0
		die()
		
func heal(amount: float) -> void:
	health = min(health + amount, MAX_HP)
	
func die() -> void:
	is_alive = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
