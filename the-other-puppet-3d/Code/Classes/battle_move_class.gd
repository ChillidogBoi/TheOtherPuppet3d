class_name BattleMove
extends Resource

@export var display_name: String
@export var one_liner: String
@export_enum("None", "HP", "Mercy") var damage_type: int
@export var damage_amount: int
@export var requires_timing: bool
@export_enum("1 Enemy", "All Enemies", "1 Ally", "All Allies", "All") var targets_who: int


func execute(target: Combatant = null, timing_bonus: float = 1):
	if damage_type == 0: return
	if not requires_timing: timing_bonus = 1
	
	if targets_who == 0 or targets_who == 2:
		apply_damage(target, timing_bonus)
		return
	
	if targets_who == 4:
		var targs = Party.party.duplicate()
		targs.append_array(Party.enemy_party)
		for n in targs:
			apply_damage(n, timing_bonus)
		return
	
	if targets_who == 1:
		for n in Party.enemy_party:
			apply_damage(n, timing_bonus)
		return
	
	for n in Party.party:
		apply_damage(n, timing_bonus)

func apply_damage(target: Combatant, timing_bonus: float = 1):
	
	if damage_type == 2:
		target.current_mercy += damage_amount
		return
	
	target.current_HP -= damage_amount
