extends VBoxContainer

signal button_pressed
var last_button_pressed: InputEvent

func _unhandled_input(event):
	if event is InputEventMouseMotion: return
	if not event.is_pressed(): return
	if event.as_text() == "Escape": return
	last_button_pressed = event
	button_pressed.emit()
