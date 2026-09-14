extends PlayerMoveState

@export var fall_speed: float = 2.0
const JUMP_HEIGHT = 5.25
const MAX_JUMP_LENGTH = 0.2
const JUMP_HOLD_BOOST = 64.0
var time = 0.0

func enter_function():
	time = 0.0
	body.velocity.y = JUMP_HEIGHT

func premove_function(_delta: float, _inputs:int):
	time += _delta
	body.velocity += body.get_gravity() * _delta * fall_speed / JUMP_HOLD_BOOST

func correct_state_test(_inputs:int) -> String:
	if time > MAX_JUMP_LENGTH: return "Fall"
	if (_inputs & INPUT_NAMES.JUMP_HELD) == 0: return "Fall"
	return CURRENT_STATE_IS_CORRECT
