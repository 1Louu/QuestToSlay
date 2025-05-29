extends Entity
class_name Mob 

@export var ExpValue: float = 2
@export_group("Nodes export")
@export var player_ref: Player
@export var melee_ref: IAMelee

func _ready() -> void:
	super._ready()

func _physics_process(delta: float) -> void:
	if(player_ref):
		set_direction(player_ref)
	if(melee_ref.isNotAttacking()):
		apply_movement(delta)
		move_and_slide()
	if(melee_ref.has_overlapping_bodies()&& melee_ref.isNotAttacking()):
		MobAttack()

func set_direction(target: Entity): 
	var target_pos = target.global_position
	var me_pos = global_position
	direction = (target_pos - me_pos).normalized()

func die():
	player_ref.gainExp(ExpValue) 
	super.die()
	
## Reason why this function is a separate one is so that for each mob, i can override and reuse for animations and mob specifics purpose
func MobAttack(): 
	if(melee_ref.TryAttack()):
		print("I attacked")
