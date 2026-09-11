extends ColorRect

@export var initial_button: Button

func _ready():
	assert(initial_button != null, "Exported variable \"initial_button\" not initialized to type \"Button\"")
	initial_button.grab_focus()
