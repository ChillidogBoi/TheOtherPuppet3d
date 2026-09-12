class_name StateMachine
extends Node

@export var currentState: State

func _ready():
	assert(currentState != null, "Exported variable \"currentState\" not initialized to type \"State\"")
	currentState.enter_function()

func _physics_process(delta):
	var inputs: int = get_inputs()
	
	currentState.physics_function(delta, inputs)
	
	# handle state changes
	var correct_state: String = currentState.correct_state_test(inputs)
	if correct_state == "STAY_AS_SELF": return
	currentState.exit_function()
	currentState = find_child(correct_state)
	currentState.enter_function() # currentState is the new state here

func _process(delta):
	currentState.function(delta)

func get_inputs() -> int:
	return 0
