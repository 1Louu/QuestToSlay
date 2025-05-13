class_name Player
extends Entity

@export var JUMP_VELOCITY = 5
@export var camera_sensitivity: float = 0.002

#var score: int = 0
#var collected_items: Dictionary = {}
var camera_rotation: Vector3 = Vector3.ZERO 
var input_enabled: bool = true

@onready var camera_pivot = $CameraPivot
@onready var camera_3d = $CameraPivot/Camera3D
@onready var interaction_ray = $CameraPivot/Camera3D/InteractionRay

signal player_died
		
func _ready() -> void:
	super._ready()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if not is_alive or not input_enabled:
		return
		
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * camera_sensitivity)
		
		camera_pivot.rotate_x(-event.relative.y * camera_sensitivity)
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -PI/2, PI/2)

func _physics_process(delta):
	if not is_alive or not input_enabled:
		return
		
	direction = get_input_direction()
	handle_jump()
	
	super._physics_process(delta)

func apply_movement(delta: float) -> void:
	var global_direction = (transform.basis * Vector3(direction.x, 0, direction.z)).normalized()
	velocity.x = lerp(velocity.x, global_direction.x * SPEED, ACCELERATION * delta)
	velocity.z = lerp(velocity.z, global_direction.z * SPEED, ACCELERATION * delta)
	
func get_input_direction() -> Vector3:
	var input_dir = Vector3.ZERO
	
	var cam_basis = camera_3d.global_transform.basis
	
	if Input.is_action_pressed("move_forward"):
		input_dir -= cam_basis.z
	if Input.is_action_pressed("move_backward"):
		input_dir += cam_basis.z
	if Input.is_action_pressed("move_left"):
		input_dir -= cam_basis.x
	if Input.is_action_pressed("move_right"):
		input_dir += cam_basis.x
		
	input_dir.y = 0
	return input_dir.normalized() if input_dir.length() > 0 else Vector3.ZERO

func handle_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY

#func update_animation() -> void:
	#if not animation_player:
		#return
	
	#if not is_on_floor():
		#if velocity.y > 0:
			#animation_player.play("jump")
		#else:
			#animation_player.play("fall")
	#elif direction != Vector3.ZERO:
		#animation_player.play("run")
	#else:
		#animation_player.play("idle")
		
func die() -> void:
	super.die() 
	#animation_player.play("death")
	input_enabled = false
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	emit_signal("player_died")
	
	#await animation_player.animation_finished

func reset_player() -> void:
	health = MAX_HP
	is_alive = true
	input_enabled = true
	velocity = Vector3.ZERO
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
