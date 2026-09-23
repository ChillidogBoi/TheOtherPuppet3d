extends State

var next_state: String
@onready var oneliner = $"../../PanelContainer/Label"
@export var party_menus: Array[Control]

func _ready():
	next_state = CURRENT_STATE_IS_CORRECT

func enter_function():
	Party.party_turn += 1
	next_state = CURRENT_STATE_IS_CORRECT
	var one_liner: String = Party.enemy_party[
		randi_range(0, Party.enemy_party.size() - 1)
	].generate_oneliner()
	oneliner.text = one_liner
	
	print(Party.party_turn)
	
	party_menus[Party.party_turn].open_menu()
	await party_menus[Party.party_turn].turn_finished
	party_menus[Party.party_turn].close_menu()
	if party_menus.size() - 1 > Party.party_turn: next_state = name
	else: next_state = "EnemyTurn"

func exit_function():
	if next_state == "EnemyTurn":
		Party.party_turn = -1

func correct_state_test(_inputs:int) -> String:
	return next_state
