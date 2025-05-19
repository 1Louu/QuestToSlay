extends Entity 
class_name Player

var look_dir: Vector2

var can_attack = false

@export var UI: Control


@export var camera_sensitivity: float = 0.002

#var score: int = 0
#var collected_items: Dictionary = {}
var camera_rotation: Vector2 = Vector2.ZERO 
var input_enabled: bool = true

@onready var camera_pivot = $Pivot
@onready var camera_3d = $Pivot/Camera3D
@onready var interaction_ray = $Pivot/Camera3D/InteractionRay

signal player_died

var mouse_captured: bool = true # variable to check if the mouse is centered or not. This to make the mouse not go outside the game.

@onready var Target= $Pivot/TargetMob

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		
func _ready() -> void:
	capture_mouse()
#
	#$Area3D.connect("body_entered", _on_attack_range_body_entered)
	#$Area3D.connect("body_exited", _on_attack_range_body_exited)
	super._ready()
	
func _input(event):
	if not input_enabled:
		return
		
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * camera_sensitivity)
		
		camera_pivot.rotate_x(-event.relative.y * camera_sensitivity)
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -PI/2, PI/2)

func _physics_process(delta):
	if not input_enabled:
		return
		
	direction = get_input_direction()
	handle_jump()
	
	super._physics_process(delta)

func apply_movement(delta: float) -> void:
	var global_direction = (transform.basis * Vector3(direction.x, 0, direction.z)).normalized()
	velocity.x = lerp(velocity.x, global_direction.x * SPD, ACCELERATION * delta)
	velocity.z = lerp(velocity.z, global_direction.z * SPD, ACCELERATION * delta)
	
func get_input_direction() -> Vector3:
	var input_dir = Vector3.ZERO

	
	if Input.is_action_pressed("move_forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("move_backward"):
		input_dir.z += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
		
	input_dir.y = 0
	return input_dir.normalized()
	
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
	
func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func _on_pause_game_paused() -> void:
	if(mouse_captured):
		release_mouse()
	else:
		capture_mouse()

func _on_target_mob_target(targbody: Mob) -> void:
	UI.targetfound(targbody)


func _on_target_mob_off_target() -> void:
	UI.OffTarget()
	
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
