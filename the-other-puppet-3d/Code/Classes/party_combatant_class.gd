class_name PartyCombatant
extends Combatant

@export var experience: int
@export_flags("SWOON", "DOWN") var active_effects: int

@export_category("Battle Choices")
@export_enum("ACTs", "Magic") var can_perform: int
@export var attacks: Array[String]
@export var spells: Array[String]
@export var acts: Array[String]

@export_category("Cosmetic")
@export var ui_color: Color
@export var guts: int
@export var special_stat_1_name: String
@export var special_stat_1_value: int
@export var special_stat_2_name: String
@export var special_stat_2_value: int
@export var title: String
