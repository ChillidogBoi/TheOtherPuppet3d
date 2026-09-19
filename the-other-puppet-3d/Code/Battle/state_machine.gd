extends StateMachine

@export var party: Array[PartyCombatant]
@export var enemy_party: Array[EnemyCombatant]
@export var items: Array[BattleMove]

# Called when the node enters the scene tree for the first time.
func _ready():
	Party.party = party
	Party.enemy_party = enemy_party
	
	currentState.enter_function()
