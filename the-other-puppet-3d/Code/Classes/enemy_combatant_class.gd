class_name EnemyCombatant
extends Combatant

@export var OneLiners: Array[String]


func generate_oneliner() -> String:
	return OneLiners[randi_range(0, OneLiners.size() - 1)]
