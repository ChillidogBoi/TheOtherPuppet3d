extends State

var next_state: String
@onready var oneliner = $"../../PanelContainer/Label"
@export var party_menus: Array[Control]

func _ready():
	next_state = CURRENT_STATE_IS_CORRECT

func enter_function():
	next_state = CURRENT_STATE_IS_CORRECT
	var one_liner: String = Party.enemy_party[
		randi_range(0, Party.enemy_party.size() - 1)
	].generate_oneliner()
	oneliner.text = one_liner
	
	party_menus[Party.party_turn].open_menu()
	await party_menus[Party.party_turn].turn_finished
	Party.party_turn += 1
	if party_menus.size() > Party.party_turn: next_state = name
	else: next_state = "EnemyTurn"

func exit_function():
	Party.party_turn = 0

func correct_state_test(_inputs:int) -> String:
	return next_state
