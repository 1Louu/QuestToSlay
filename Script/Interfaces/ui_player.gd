extends Control

@onready var Targetlabel = $VBoxTarget/TargetLabel
@onready var TargetHPBar= $"VBoxTarget/TargetHP"
@onready var targetUI= $VBoxTarget


func targetfound(target: Mob): 
	targetUI.show()
	Targetlabel.set_text(target.Name) 
	TargetHPBar.set_max(target.MaxHP)
	TargetHPBar.set_value(target.CurrentHP)

func OffTarget():
	targetUI.hide()
