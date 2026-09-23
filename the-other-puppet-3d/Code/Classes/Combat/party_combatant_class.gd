class_name PartyCombatant
extends Combatant

@export var experience: int
@export_flags("SWOON", "DOWN") var active_effects: int

@export_category("Battle Choices")
@export_enum("ACTs", "Magic") var can_perform: int
@export var attack: BattleMove
@export var defend_move: BattleMove
@export var spells_or_acts: Array[BattleMove]

@export_category("Cosmetic")
@export var ui_color: Color
@export var guts: int
@export var special_stat_1_name: String
@export var special_stat_1_value: int
@export var special_stat_2_name: String
@export var special_stat_2_value: int
@export var title: String
