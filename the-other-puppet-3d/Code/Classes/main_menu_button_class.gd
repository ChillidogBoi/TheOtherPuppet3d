class_name MainMenuButton
extends HBoxContainer

var button: Button
var label: Control

func _ready():
	for child in get_children():
		if child is Button: button = child
		if child is Label: label = child
	label.connect("mouse_entered", button.grab_focus)
	button.connect("mouse_entered", button.grab_focus)
	label.connect("gui_input", _on_gui_input)

func _on_gui_input(event: InputEvent):
	if not event is InputEventMouseButton: return
	if not event.is_pressed(): return
	if event.button_index != 1:
		Input.parse_input_event(event)
		return
	button.pressed.emit()
