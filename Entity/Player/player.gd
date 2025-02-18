extends CharacterBody3D
var look_dir: Vector2

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var PauseMenu = $PauseGame

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		_rotate_camera()
		
func _ready() -> void:
	PausePlayer
	
func _close() -> void:
	get_tree().quit();
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("echap"):
		_close()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var cam_basis = $Camera3D.transform.basis
	
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
	$Camera3D.rotation.y -= look_dir.x * 1 * sens_mod
	$Camera3D.rotation.x -= look_dir.y * 1 * sens_mod
	
func PausePlayer():
	if Global.paused: 
		$PausedMenu.hide()
		capture_mouse()
	else: 
		$PausedMenu.show()
	
