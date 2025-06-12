extends Resource
class_name BaseUpgrade
## {NONE, PLAYER, MAGIC, FIRE, WEAPON, SWORD}
enum type {NONE, PLAYER, MAGIC, FIRE, WEAPON, SWORD}
## Reminder to self : Again, do not pass reference node to node again. Use signal insteads
var player_ref
@export_category("BaseRessources")
@export var upgradeName: String = "None"
@export var descript: String
@export var uptype:type

func upgradePlayer():
    pass
