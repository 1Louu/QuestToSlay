extends Mob

@export_group("Node Exports")
@export var AnimTree: AnimationTree

var isAttacking: bool = false
var isAttacked: bool = false

func MobAttack():
	super.MobAttack() #Execute Parent script
	isAttacking = true

func take_damage(damage:float ):
	super.take_damage(damage)
	isAttacked= true

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(isAttacked):
		isAttacked= false
	if(isAttacking):
		isAttacking= false
