extends Node3D
class_name Weapon

@export_group("Weapon_Characteristic")
@export var DMG_Multi: float = 1
@export var TimeWind: float =0.1
@export var TimeActiveHurt: float =0.2 
@export var TimeCooldown: float =0.5
@export var player_strenght: float=1

@export_group("Node Export")
@export var melee: IAMelee
@export var AniPlayer:AnimationPlayer

func _ready() -> void:
	melee.setTimer(TimeWind, TimeActiveHurt, TimeCooldown)
	melee.MeleeDamage = player_strenght * DMG_Multi

func startAttack() -> void:
	if(melee.TryAttack()):
		AniPlayer.play("Attack")

func StrenghtUpdate(newStrnght:float) -> void:
	player_strenght= newStrnght
	melee.MeleeDamage = player_strenght * DMG_Multi
