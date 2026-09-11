class_name PlayerState
extends State

enum INPUT_NAMES {
	NORTH = 1, EAST = 2, SOUTH = 4, WEST = 8,
	ANY_DIRECTION = 15, # equal to INPUT_NAMES.NORTH | INPUT_NAMES.SOUTH | INPUT_NAMES.EAST | INPUT_NAMES.WEST
	JUMP = 16, JUMP_HELD = 32, MENU = 64,
}

@export var animation: String

var body: CharacterBody3D
var animator: AnimationPlayer

func enter_function():
	if animation == "": return
	animator.play(animation)
