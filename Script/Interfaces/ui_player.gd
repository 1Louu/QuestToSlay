extends Control

@export_group("Node Exports")
@export var LifeBar: ProgressBar
@export var ManaBar: ProgressBar
@export var ExperienceBar: ProgressBar
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

func updateMaxBar(maxvalue:float, bar: String):
	if (bar == "Life"):
		LifeBar.set_max(maxvalue)
	if (bar == "Mana"):
		ManaBar.set_max(maxvalue)
	if (bar == "Exp"):
		ExperienceBar.set_max(maxvalue)

func updateBar(value: float, bar: String):
	if (bar == "Life"):
		LifeBar.set_value(value)
	if (bar == "Mana"):
		ManaBar.set_value(value)
	if (bar == "Exp"):
		ExperienceBar.set_value(value)
