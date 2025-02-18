extends Control

@onready var targetlabel = $Target/TargetLabel

func targetfound(body: Entity):
	targetlabel.set_text(body.Entityname) 
	
