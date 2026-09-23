class_name EnemyCombatant
extends Combatant

@export var OneLiners: Array[String]
@export var required_mercy: int
@export var current_mercy: int:
	set(v):
		current_mercy = v
		if mercy_bar == null: return
		mercy_bar.value = round((float(current_mercy) / float(required_mercy)) * 100.0)
@export var mercy_bar: ProgressBar = null
@export var attacks: Array[PackedScene]

func generate_oneliner() -> String:
	return OneLiners[randi_range(0, OneLiners.size() - 1)]
