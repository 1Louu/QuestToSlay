extends BaseUpgrade

@export_category("FireballUpgrade")
@export var fireballRange: float
@export var fireballexplosion: float

func upgradePlayer():
    player_ref.magic; 
