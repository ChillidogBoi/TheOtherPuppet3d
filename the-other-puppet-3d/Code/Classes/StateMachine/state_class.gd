class_name State
extends Node

const CURRENT_STATE_IS_CORRECT = "STAY_AS_SELF"

# called every frame
func function(_delta: float):
	return
# called on enter (for starting animations and jumps)
func enter_function():
	return
# exit function (resets timers)
func exit_function():
	return
# called every physics frame (movement code here)
func physics_function(_delta: float, _inputs:int):
	return

# returns the correct state as a string to be passed to the function "find_child()"
func correct_state_test(_inputs:int) -> String:
	return CURRENT_STATE_IS_CORRECT
