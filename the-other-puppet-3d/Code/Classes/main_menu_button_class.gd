class_name MainMenuButton
extends HBoxContainer

var button: Button
var label: Control

func _ready():
	for child in get_children():
		if child is Button: button = child
		if child is Label: label = child
	label.connect("mouse_entered", button.grab_focus)
	label.connect("mouse_exited", button.release_focus)
	label.connect("gui_input", _on_gui_input)

func _on_gui_input(event: InputEvent):
	if not event is InputEventMouseButton: return
	if not event.is_pressed(): return
	button.pressed.emit()
