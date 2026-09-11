class_name MainMenuButton
extends HBoxContainer

var button: Button
var label: Label

func _ready():
	for child in get_children():
		if child is Button: button = child
		if child is Label: label = child
	label.connect("mouse_entered", button.grab_focus)
	label.connect("mouse_exited", button.release_focus)
	label.connect("gui_input", button.pressed.emit)
