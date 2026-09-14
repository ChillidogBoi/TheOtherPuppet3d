class_name PlayerMoveState
extends PlayerState

@export_custom(PROPERTY_HINT_NONE, "suffix:m/s") var SPEED: float = 4.5

func _ready():
#	SPEED *= 60.0 # adjust to meters per second
	pass

func correct_state_test(_inputs:int) -> String:
	if not body.is_on_floor(): return "Fall"
	
	if _inputs & INPUT_NAMES.MENU: return "Menu"
	
	if _inputs & INPUT_NAMES.JUMP: return "Jump"
	
	return CURRENT_STATE_IS_CORRECT

# don't overwrite this function, use "premove_function()"
func physics_function(_delta: float, _inputs:int):
	premove_function(_delta, _inputs)
	
	var input_direction := Vector3(
		float(_inputs & INPUT_NAMES.EAST > 0) - float(_inputs & INPUT_NAMES.WEST > 0),
		0.0,
		float(_inputs & INPUT_NAMES.SOUTH > 0) - float(_inputs & INPUT_NAMES.NORTH > 0)
	).normalized()
	
	#                    adjust for camera facing direction      and lag 
	input_direction = (body.transform.basis * input_direction) * SPEED # and apply speed
	body.velocity = Vector3(input_direction.x, body.velocity.y, input_direction.z) # apply to body
	body.move_and_slide()

func premove_function(_delta: float, _inputs:int):
	pass
