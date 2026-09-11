extends ColorRect

@export var initial_button: Button
@export var loading_screen: AnimationPlayer
@export var transitions: AnimationPlayer
@export_category("menus")


func _ready():
	assert(loading_screen != null, "Exported variable \"loading_screen\" not initialized to type \"AnimationPlayer\"")
	loading_screen.play_backwards("fade_in")
	assert(initial_button != null, "Exported variable \"initial_button\" not initialized to type \"Button\"")
	initial_button.grab_focus()


func _on_options_pressed():
	pass
