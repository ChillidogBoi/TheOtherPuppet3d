class_name Combatant
extends Node

@export var display_name: String
@export var max_HP: int
@export var current_HP: int:
	set(v):
		current_HP = v
		_on_HP_set(v)
@export var base_defense: int
var current_defense: int
@export var base_magic: int
var current_magic: int
@export var level: int
@export var health_bars: Array[ProgressBar]


func _on_HP_set(value: int):
	for n in health_bars:
		if n != null: n.value = round((float(current_HP) / float(max_HP)) * 100.0)
	print(current_HP)

func _ready():
	initialize_side()
	current_defense = base_defense
	current_magic = base_magic

func initialize_side():
	pass
