extends Node
class_name MobManager

@export_group("Node exports")
@export var MobSceneList:Array[PackedScene]
@export var TimerRef: Timer
@export var PlayerRef:Player
@export_group("Settings")
@export var MaxMobSpawn: int = 5
@export var intervalSpawn: float = 1

var MobCount: int = 0
var SpawnList:Array[Marker3D]

func _ready() -> void:
    TimerRef.start(intervalSpawn)

func _on_timer_timeout() -> void:
    if MobCount < MaxMobSpawn: 
        var instanceMob =  MobSceneList[0].instantiate() as Mob
        get_parent().get_parent().add_child(instanceMob)
        instanceMob.player_ref = PlayerRef
        instanceMob.global_position = SpawnList[randi() % SpawnList.size()].global_position
        MobCount = MobCount + 1 
        print(MobCount)

func _on_spawn_spawn(reference: Node3D) -> void:
    SpawnList.push_back(reference)
