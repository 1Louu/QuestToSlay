extends Node3D
class_name Entity

@export var MaxHP: float 
@export var CurrentHP: float  

@export var Strenght: float

@export var MaxMana: float
@export var Mana: float

@export var SPD: float
@export var armor: float
@export var Entityname:String  

func _ready(): 
	CurrentHP = MaxHP

func takeDmg(damage: float ):
	CurrentHP -= damage / armor 
	if (CurrentHP < 0): 
		dieprocess();

func gainHP(life: float):
	CurrentHP += life
	if(CurrentHP > MaxHP):
		CurrentHP = MaxHP

func getEntName(): 
	return Entityname

func dieprocess(): 
	free()
