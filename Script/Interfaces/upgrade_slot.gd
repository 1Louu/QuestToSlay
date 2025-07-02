extends Control
class_name LvlUpSlot

@export_group("Node Exports")
## Reminder to self : Do not pass reference node to node again. Use signal insteads
@export var PlayerRef: Player
@export var Upgrade: BaseUpgrade
@export var UpgradeName: Label
@export var UpgradeImage: TextureRect
@export var UpgradeDescrpt: Label

func _ready() -> void:
    updateUpgrade()
    
func updateUpgrade() -> void: 
    UpgradeName.text = Upgrade.upgradeName
    UpgradeDescrpt.text = Upgrade.descript
    Upgrade.PlayerRef = PlayerRef
    match Upgrade.type:
        "NONE":
            return
        "PLAYER": 
            setUpgradeImage("res://Assets/Upgrades/Upgrade - Player.png")
        "MAGIC":
            setUpgradeImage("res://Assets/Upgrades/Upgrade - Magic.png")
        "WEAPON":
            setUpgradeImage("res://Assets/Upgrades/Upgrade - Weapon.png")
        "FIRE":
            setUpgradeImage("res://Assets/Upgrades/Upgrade - Fire.png")
            
func _on_pressed() -> void:
    Upgrade.upgradePlayer()

func setUpgradeImage(path: String) -> void:
    var image = Image.new()
    image.load(path)
    if(image):
        UpgradeImage.image = image
    else: 
        print("Error Loading Image from upgrade_slot.")
