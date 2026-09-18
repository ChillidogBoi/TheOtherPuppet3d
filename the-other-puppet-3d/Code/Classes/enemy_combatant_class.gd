class_name EnemyCombatant
extends Combatant

@export var OneLiners: Array[String]
@export var required_mercy: int
@export var current_mercy: int


func generate_oneliner() -> String:
	return OneLiners[randi_range(0, OneLiners.size() - 1)]
