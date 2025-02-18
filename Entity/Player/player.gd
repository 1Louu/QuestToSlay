extends CharacterBody3D 
class_name Player

var look_dir: Vector2

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var mouse_captured: bool = false # variable to check if the mouse is centered or not. This to make the mouse not go outside the game.

@onready var PauseMenu = $PauseGame
@onready var UI = $UIPlayer
@onready var Target= $Pivot/TargetMob

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		_rotate_camera()
		
func _ready() -> void:
	capture_mouse()

func _close() -> void:
	get_tree().quit();
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var cam_basis = $Pivot.transform.basis
	
	var forward = -cam_basis.z.normalized()
	var right = cam_basis.x.normalized()
	forward.y = 0
	right.y = 0
	forward = forward.normalized()
	right = right.normalized()
	
	var direction = (-forward * input_dir.y + right * input_dir.x).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _rotate_camera(sens_mod: float = 1.0) -> void:
	$Pivot.rotation.y -= look_dir.x * 1 * sens_mod
	$Pivot.rotation.x -= look_dir.y * 1 * sens_mod
	
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

func _on_target_mob_target() -> void:
	if(Target.get_class()):
		UI.targetfound(Target.targbody)
	
	
