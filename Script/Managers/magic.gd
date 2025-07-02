extends Node
class_name MagicManager 

@export_group("Node exports")
@export var magicList:Array[PackedScene]
@export var timerCdMagic: Timer
@export var damageMagic: float = 1
@export var playerRef:Player
@export var magic_cost: float = 1


var indexMagic: int = 0

func castMagic()-> void:
    if(playerRef.Mana >= magic_cost && timerCdMagic.is_stopped()):
        var instanceMagic = magicList[indexMagic].instantiate()
        get_parent().get_parent().add_child(instanceMagic)
        instanceMagic.position = playerRef.global_position
        instanceMagic.rotation = playerRef.rotation
        instanceMagic.rotation.x += playerRef.camera_pivot.rotation.x + deg_to_rad(180)
        playerRef.Mana -= magic_cost
        playerRef.UI.updateBar(playerRef.Mana, "Mana")
        timerCdMagic.start()
