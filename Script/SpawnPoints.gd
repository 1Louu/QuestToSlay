extends Marker3D

signal Spawn

func _ready() -> void:
    Spawn.emit(self)
