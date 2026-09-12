extends PlayerState

@export var menu: Control = null
var closing := true

func _ready():
	assert(menu != null, "Exported variable \"menu\" not initialized to type \"Control\"")


func correct_state_test(_inputs:int) -> String:
	if closing: return "Fall"
	
	if (_inputs & INPUT_NAMES.MENU) > 0: return "Fall"
	
	return CURRENT_STATE_IS_CORRECT
