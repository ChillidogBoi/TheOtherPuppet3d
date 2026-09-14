extends VBoxContainer

signal button_pressed
var last_button_pressed: InputEvent
@onready var v_slider = $"../VSlider"
var item_thickness: int
var children: Array[Node]
@onready var mouse = $MouseSens/SpinBox
@onready var stick = $StickSens/SpinBox


func _ready():
	v_slider.max_value = get_child_count()
	item_thickness = get_child(-2).size.y
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
	for n:int in children.size():
		children[n].offset_transform_position.y = (-value * item_thickness)


func _on_mouse_up_pressed():
	if mouse.value >= 999: return
	Settings.mouse_sensitivity += 1 / pow(2, 16)
	mouse.value += 1
func _on_mouse_down_pressed():
	if mouse.value <= 0: return
	Settings.mouse_sensitivity -= 1 / pow(2, 16)
	mouse.value -= 1
func _on_mouse_changed(value):
	Settings.mouse_sensitivity = value / pow(2, 16)

func _on_stick_up_pressed():
	if stick.value >= 999: return
	Settings.stick_sensitivity += 1 / pow(2, 12)
	stick.value += 1
func _on_stick_down_pressed():
	if stick.value <= 0: return
	Settings.stick_sensitivity -= 1 / pow(2, 12)
	stick.value -= 1
func _on_stick_changed(value):
	Settings.stick_sensitivity = value / pow(2, 12)
