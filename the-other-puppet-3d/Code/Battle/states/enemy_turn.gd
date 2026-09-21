extends BattleState

var next_state: String

func _ready():
	next_state = CURRENT_STATE_IS_CORRECT

func enter_function():
	

func correct_state_test(_inputs:int) -> String:
	return next_state
