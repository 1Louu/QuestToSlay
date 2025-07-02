extends Control

@export_category("Node Exports")
@export var PlayerRef: Player
@export var Slots: Array[LvlUpSlot]

func _ready():
    for Slot:LvlUpSlot in Slots:
        Slot.PlayerRef = PlayerRef

func SetUpgrades(Upgrds: Array[BaseUpgrade]):
    if(len(Upgrds) == len(Slots) or len(Upgrds) > len(Slots)):
        if (len(Upgrds) > len(Slots)): 
            print("Warning, too many upgrades are presented, lastest one(s) will be discarded")
        for Slot in len(Slots):
            Slots[Slot-1].Upgrade = Upgrds[Slot-1]
            Slots[Slot-1].updateUpgrade()
    else: 
        print("Upgrades were too small to fit the upgrades list")
        return
