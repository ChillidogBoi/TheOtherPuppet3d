extends PlayerState

@export var menu: Control = null
var closing := false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	assert(menu != null, "Exported variable \"menu\" not initialized to type \"Control\"")
func enter_function():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	menu.visible = true
	closing = false
func exit_function():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	menu.visible = false


func correct_state_test(_inputs:int) -> String:
	if closing: return "Fall"
	
	if (_inputs & INPUT_NAMES.MENU) > 0: return "Fall"
	
	return CURRENT_STATE_IS_CORRECT
