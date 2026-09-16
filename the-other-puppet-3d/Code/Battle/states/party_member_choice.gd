extends State

@export var next_state: String
@onready var oneliner = $"../../PanelContainer/Label"
@export var party_menus: Array[Control]

func _ready():
	next_state = CURRENT_STATE_IS_CORRECT

func enter_function():
	print(Party.enemy_party)
	next_state = CURRENT_STATE_IS_CORRECT
	var one_liner: String = Party.enemy_party[
		randi_range(0, Party.enemy_party.size() - 1)
	].generate_oneliner()
	oneliner.text = one_liner
	
	party_menus[Party.party_turn].open_menu()

func correct_state_test(_inputs:int) -> String:
	return next_state
