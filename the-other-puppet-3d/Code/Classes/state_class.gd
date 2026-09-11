class_name State
extends Node

# called every frame
func function(delta: float):
	return
# called on enter (for jump)
func enter_function():
	return
# exit function (resets timers)
func exit_function():
	return
# called every physics frame (movement code here)
func physics_function(delta: float, inputs:int):
	return

# returns the correct state as a string to be passed to the function "find_child()"
func correct_state_test(inputs:int) -> String:
	return "self"
