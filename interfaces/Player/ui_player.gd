extends Control

@onready var Targetlabel = $Target/TargetLabel
@onready var TargetHPBar= $"Target/TargetHP"


func targetfound(target: mob): 
	$"Target".show()
	Targetlabel.set_text(target.Entityname) 
	print(target.Entityname)	
	TargetHPBar.set_max(target.MaxHP)
	TargetHPBar.set_value(target.CurrentHP)

func OffTarget():
	$"Target".hide()
