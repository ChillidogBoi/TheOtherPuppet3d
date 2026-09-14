extends PlayerMoveState

@export var fall_speed: float = 2.0

func premove_function(_delta: float, _inputs:int):
	body.velocity += body.get_gravity() * _delta * fall_speed

func correct_state_test(_inputs:int) -> String:
	if not body.is_on_floor(): 
		if _inputs & INPUT_NAMES.MENU: return "Menu"
		return CURRENT_STATE_IS_CORRECT
	
	if _inputs & INPUT_NAMES.ANY_DIRECTION: return "Walk"
	
	return "Idle"
