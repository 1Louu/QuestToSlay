extends Control

@onready var Targetlabel = $VBoxTarget/TargetLabel
@onready var TargetHPBar= $"VBoxTarget/TargetHP"


func targetfound(target: mob): 
	$"VBoxTarget".show()
	Targetlabel.set_text(target.Entityname) 
	TargetHPBar.set_max(target.MaxHP)
	TargetHPBar.set_value(target.CurrentHP)

func OffTarget():
	$"VBoxTarget".hide()
