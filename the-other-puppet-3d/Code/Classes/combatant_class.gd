class_name Combatant
extends Node

@export var display_name: String
@export var max_HP: int
@export var current_HP: int
@export var base_defense: int
var current_defense: int
@export var base_magic: int
var current_magic: int
@export var level: int


func _ready():
	initialize_side()
	current_defense = base_defense
	current_magic = base_magic

func initialize_side():
	pass
