extends projectile

@export_group("Node exports")
@export var explosion_scene: PackedScene
@export var explosion_range: float = 0 

func createExplosion(): 
    if(explosion_range>0):
        var instanceExplosion = explosion_scene.instantiate()
        get_parent().get_parent().add_child(instanceExplosion)
        
