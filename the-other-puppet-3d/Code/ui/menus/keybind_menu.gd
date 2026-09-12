extends VBoxContainer

signal button_pressed
var last_button_pressed: InputEvent
@onready var v_slider = $"../VSlider"
var item_thickness: int
var children: Array[Node]

func _ready():
	v_slider.max_value = get_child_count()
	item_thickness = get_child(1).size.y
	await RenderingServer.frame_post_draw
	children = get_children()

func _unhandled_input(event):
	if event is InputEventMouseMotion: return
	if not event.is_pressed(): return
	if event.as_text() == "Escape": return
	if event.as_text() == "Mouse Wheel Up":
		v_slider.value -= 1
		return
	if event.as_text() == "Mouse Wheel Down":
		v_slider.value += 1
		return
	last_button_pressed = event
	button_pressed.emit()


func _on_v_slider_value_changed(value):
	for n in children:
		n.offset_transform_position.y = -value * item_thickness
