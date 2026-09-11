extends PlayerState

func enter_function():
	pass # play animations here

func correct_state_test(_inputs:int) -> String:
	if not body.is_on_floor(): return "Fall"
	
	if _inputs & INPUT_NAMES.JUMP: return "Jump"
	
	if _inputs & INPUT_NAMES.ANY_DIRECTION: return "Walk"
	
	return CURRENT_STATE_IS_CORRECT
