extends Control

@export_enum("Shrink Begin", "Shrink Center", "Shrink End") var align: int
@export var character: PartyCombatant
@export var character_portrait: Texture2D

@onready var progress_bar = $VBoxContainer/Cover/ProgressBar
@onready var portrait = $VBoxContainer/Cover/Portrait
@onready var name_label = $VBoxContainer/Cover/Name
@onready var performs: Array[Control] = [
	$VBoxContainer/Buttons/HBoxContainer/ACT, $VBoxContainer/Buttons/HBoxContainer/Magic]
@onready var initial_button = $VBoxContainer/Buttons/HBoxContainer/Fight
@onready var align_me = [$VBoxContainer/Cover, $VBoxContainer/Buttons]
@onready var item_button = $VBoxContainer/Buttons/HBoxContainer/Item
@onready var grid_container = $VBoxContainer/ColorRect/GridContainer
@onready var buttons = $VBoxContainer/Buttons
@onready var cover = $VBoxContainer/Cover

const PANEL_1 = preload("uid://i83mt0qkyagd")
const PANEL_2 = preload("uid://wcmo0xppvm0e")


# Called when the node enters the scene tree for the first time.
func _ready():
	grid_container.visible = false
	buttons.visible = false
	cover.set("theme_override_styles/panel", PANEL_2)
	
	portrait.texture = character_portrait
	for n: Control in align_me:
		n.size_flags_horizontal = align * 4 as Control.SizeFlags
	
	progress_bar.max_value = character.max_HP
	progress_bar.value = character.current_HP
	
	for n in performs:
		n.visible = false
	performs[character.can_perform].visible = true
	performs[character.can_perform].focus_neighbor_left = \
		performs[character.can_perform].get_path_to(initial_button)
	performs[character.can_perform].focus_neighbor_right = \
		performs[character.can_perform].get_path_to(item_button)
	initial_button.focus_neighbor_right = \
		initial_button.get_path_to(performs[character.can_perform])
	item_button.focus_neighbor_left = \
		item_button.get_path_to(performs[character.can_perform])
	
	name_label.text = character.name
	
	var color_me: Array = align_me
	color_me.append(progress_bar)
	for node: Control in color_me:
		node.self_modulate = character.ui_color


func _on_button1_pressed():
	pass # Replace with function body.


func _on_button2_pressed():
	pass # Replace with function body.


func _on_button3_pressed():
	pass # Replace with function body.


func _on_button4_pressed():
	pass # Replace with function body.


func _on_button5_pressed():
	pass # Replace with function body.


func _on_button6_pressed():
	pass # Replace with function body.
