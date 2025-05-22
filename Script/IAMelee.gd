extends Area3D
class_name IAMelee ## Interface Attack Melee
# Refactorized scene as most melee attack will always be using the same script. 

@export_group("Node Exports")
## variable to determine the number of damage. by default it is assigned as 1, however it should be changed through other entities
@export var MeleeDamage: float = 1
## Timer to show an incoming attack
@export var TimerWind: Timer
## Timer whose main purpose of activeHurt is to make the attack have a lasting hurt box,better for a more "fluid" attack
@export var TimerActiveHurt: Timer
## Timer to determine whenever target entity may attack again
@export var Cooldown: Timer
@export var HurtBox: Area3D

@export_group("Timer Setting")
## Winding Up attack time in seconds
@export var TSWind: float =0.1
## Time in seconds of hurtbox being active
@export var TSActiveHurt: float =0.2
## Time in seconds of cooldown before another attack start
@export var TSCooldown: float =0.5

func setTimer( T1: float, T2: float, T3: float):
	TSWind = T1
	TSActiveHurt = T2
	TSCooldown = T3

func TryAttack() -> bool:
	if(TimerWind.is_stopped() and TimerActiveHurt.is_stopped() and Cooldown.is_stopped()):
		TimerWind.start(TSWind)
		return true
	return false

func _on_timer_wind_attack_timeout() -> void:
	for body in HurtBox.get_overlapping_bodies():
		if(body is Entity):
			body.take_damage(MeleeDamage)
	TimerActiveHurt.start(TSActiveHurt)

func _on_timer_active_hurt_box_timeout() -> void:
	Cooldown.start(TSCooldown)

func _on_body_entered(body: Entity) -> void:
	if(!TimerActiveHurt.is_stopped()): # If the Hurtbox timer is active (will deal damage long as hurtbox timer is active)
		body.take_damage(MeleeDamage)

func _on_timer_cooldown_timeout() -> void:
	print("Cooldown Done")

func updateRange(newRange: Vector3):
	scale.x += newRange.x
	scale.y += newRange.y
	scale.z += newRange.z
	position.x -= newRange.x /2 
	position.z -= newRange.z /2 
	position.y -= newRange.y /2 
