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
	if(player_ref):
		set_direction(player_ref)
	apply_movement(delta)
	move_and_slide()
	
func set_direction(target: Entity): 
	var target_pos = target.global_position
	var me_pos = global_position
	direction = (target_pos - me_pos).normalized()
