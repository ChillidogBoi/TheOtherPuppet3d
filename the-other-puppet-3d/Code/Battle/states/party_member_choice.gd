extends State

@export var next_state: String

func enter_function():
	next_state = CURRENT_STATE_IS_CORRECT

func correct_state_test(_inputs:int) -> String:
	return next_state
