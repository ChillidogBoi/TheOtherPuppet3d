extends HBoxContainer

signal input_pressed

@export var action: String = ""
@export var additional_action: String = ""
@export var additional_binding: InputEvent = null
@export_enum("None", "Both", "Action", "Additional Action") var additional_binding_action: int

@export_category("Focus")
@export var neighbor_top: NodePath
@export var neighbor_bottom: NodePath

@onready var button = $MainMenuButton/Button
@onready var parent = $".."
@onready var action_l = $MainMenuButton/Label
@onready var key = $Label
@onready var label_3 = $CanvasLayer/PanelContainer/VBoxContainer/Label3
@onready var canvas_layer = $CanvasLayer

func _ready():
	if neighbor_top != NodePath(""):
		if get_node(neighbor_top).has_signal("input_pressed"):
			neighbor_top = str(neighbor_top, "/MainMenuButton/Button")
		button.focus_neighbor_top = str("../../", neighbor_top)
	if neighbor_bottom != NodePath(""):
		if get_node(neighbor_bottom).has_signal("input_pressed"):
			neighbor_bottom = str(neighbor_bottom, "/MainMenuButton/Button")
		button.focus_neighbor_bottom = str("../../", neighbor_bottom)
	
	assert(parent.has_signal("button_pressed"), "KeybindSetting placed under invalid parent")
	assert(InputMap.has_action(action), str("\"", action, "\" is not a valid InputEventAction"))
	action_l.text = action.capitalize()
	label_3.text = action.capitalize()
	name_key_label()

func name_key_label():
	key.text = ""
	for n in InputMap.action_get_events(action):
		key.text = str(key.text, ",", n.as_text().replace(" - Physical", ""))
	key.text = key.text.erase(0, 1).capitalize().replace(",", ",   ")

func _on_button_pressed():
	button.disabled = true
	canvas_layer.visible = true
	await parent.button_pressed
	var erase_me := InputMap.action_get_events(action)
	for old_action in erase_me:
		InputMap.action_erase_event(action, old_action)
		if additional_action != null: InputMap.action_erase_event(additional_action, old_action)
	
	InputMap.action_add_event(action, parent.last_button_pressed)
	if [1, 2].has(additional_binding_action):
		InputMap.action_add_event(action, additional_binding)
	
	if additional_action.length() > 0: 
		InputMap.action_add_event(additional_action, parent.last_button_pressed)
		if [1, 3].has(additional_binding_action):
			InputMap.action_add_event(additional_action, additional_binding)
	
	canvas_layer.visible = false
	name_key_label()
	
	button.disabled = false
	
