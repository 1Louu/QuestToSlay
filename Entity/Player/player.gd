extends CharacterBody3D
var look_dir: Vector2

@export var mob: Node3D 
var can_attack = false

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var ATTACK = 5
@export var DEFENSE = 5
@export var HP = 5


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		_rotate_camera()
		
func _ready() -> void:
	$Area3D.connect("body_entered", _on_attack_range_body_entered)
	$Area3D.connect("body_exited", _on_attack_range_body_exited)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta: float) -> void:
	if can_attack and Input.is_action_just_pressed("attack"):
		print("Mob hit!")
	
func _on_attack_range_body_entered(body: Node) -> void:
	if body == mob:
		can_attack = true
		
func _on_attack_range_body_exited(body: Node) -> void:
	if body == mob:
		can_attack = false

func _close() -> void:
	get_tree().quit();
	
func _isDead() -> void:
	if (HP <= 0):
		get_tree().change_scene_to_file("res://interfaces/mainmenu.tscn")
	
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
