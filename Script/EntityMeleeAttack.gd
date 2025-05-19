extends Area3D

@export_group("Node Exports")
## Me, an entity able to melee attack.
@export var Me: Entity
## Timer to show an incoming attack
@export var TimerWind: Timer
## Timer whose main purpose of activeHurt is to make the attack have a lasting hurt box,better for a more "fluid" attack
@export var TimerActiveHurt: Timer
## Timer to determine whenever target entity may attack again
@export var Cooldown: Timer
@export var MeleeHurtBoxRange: Area3D

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

func startTimer():
	if(TimerWind.is_stopped() or TimerActiveHurt.is_stopped() or Cooldown.is_stopped()):
		TimerWind.start(TSWind)
	
func _on_timer_wind_attack_timeout() -> void:
	for body in MeleeHurtBoxRange.get_overlapping_bodies():
		if(body is Entity):
			body.take_damage(Me.Strenght)
	TimerActiveHurt.start(TSActiveHurt)
	
func _on_timer_active_hurt_box_timeout() -> void:
	Cooldown.start(TSCooldown)

func _on_body_entered(body: Entity) -> void:
	if(!TimerActiveHurt.is_stopped()): # If the Hurtbox timer is active (will deal damage long as hurtbox timer is active)
		body.take_damage(Me.Strenght)
