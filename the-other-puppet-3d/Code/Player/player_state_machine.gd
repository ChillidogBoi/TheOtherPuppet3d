extends StateMachine

enum INPUT_NAMES {
	NORTH = 1, EAST = 2, SOUTH = 4, WEST = 8,
	ANY_DIRECTION = 15, # equal to INPUT_NAMES.NORTH | INPUT_NAMES.SOUTH | INPUT_NAMES.EAST | INPUT_NAMES.WEST
	JUMP = 16, JUMP_HELD = 32, MENU = 64,
}
const TRACKED_INPUT_HELD_ACTIONS = {
	"move_forwards" = INPUT_NAMES.NORTH, "strafe_right" = INPUT_NAMES.EAST,
	"move_backwards" = INPUT_NAMES.SOUTH, "strafe_left" = INPUT_NAMES.WEST,
	"jump" = INPUT_NAMES.JUMP_HELD
}
const TRACKED_INPUT_TAP_ACTIONS = {
	"jump" = INPUT_NAMES.JUMP, "pause_(menu)" = INPUT_NAMES.MENU
}

@export var body: CharacterBody3D
@export var animator: AnimationPlayer

func _ready():
	assert(currentState is PlayerState, "Exported variable \"currentState\" not initialized to type \"PlayerState\"")
	assert(body is CharacterBody3D, "Exported variable \"body\" not initialized to type \"CharacterBody3D\"")
	assert(animator is AnimationPlayer, "Exported variable \"animator\" not initialized to type \"AnimationPlayer\"")
	for child in get_children():
		if not child is PlayerState: child.queue_free()
		child.body = body
		child.animator = animator

func get_inputs() -> int:
	var bitflagmap: int = 0
	for held_action in TRACKED_INPUT_HELD_ACTIONS.keys():
		if Input.is_action_pressed(held_action): bitflagmap |= TRACKED_INPUT_HELD_ACTIONS[held_action]
	for tap_action in TRACKED_INPUT_TAP_ACTIONS.keys():
		if Input.is_action_just_pressed(tap_action): bitflagmap |= TRACKED_INPUT_TAP_ACTIONS[tap_action]
	return bitflagmap
