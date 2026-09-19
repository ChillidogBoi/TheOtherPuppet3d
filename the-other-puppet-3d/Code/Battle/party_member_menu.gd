extends Control

@export_enum("Shrink Begin", "Shrink Center", "Shrink End") var align: int
@export var character: PartyCombatant
@export var character_portrait: Texture2D

@onready var progress_bar := $VBoxContainer/Cover/ProgressBar
@onready var portrait := $VBoxContainer/Cover/Portrait
@onready var name_label := $VBoxContainer/Cover/Name
@onready var performs: Array[Control] = [
	$VBoxContainer/Buttons/HBoxContainer/ACT, $VBoxContainer/Buttons/HBoxContainer/Magic]
@onready var initial_button := $VBoxContainer/Buttons/HBoxContainer/Fight
@onready var align_me := [$VBoxContainer/Cover, $VBoxContainer/Buttons]
@onready var item_button := $VBoxContainer/Buttons/HBoxContainer/Item
@onready var more_buttons := $VBoxContainer/ColorRect
@onready var buttons := $VBoxContainer/Buttons
@onready var cover := $VBoxContainer/Cover
@onready var item_desc_label := $VBoxContainer/ColorRect/MoreButtons/Label
@onready var v_box_container := $VBoxContainer
@onready var hp_label := $VBoxContainer/Cover/HpLabel
@onready var grid_container = $VBoxContainer/ColorRect/MoreButtons/GridContainer
@onready var fight_stuff = [$VBoxContainer/ColorRect2/Goal, $VBoxContainer/ColorRect2/ColorRect]



const PANEL_1 = preload("uid://i83mt0qkyagd")
const PANEL_2 = preload("uid://wcmo0xppvm0e")


func _ready():
	more_buttons.visible = false
	buttons.visible = false
	v_box_container.position = Vector2(0, 338)
	cover.set("theme_override_styles/panel", PANEL_2)
	
	portrait.texture = character_portrait
	for n: Control in align_me:
		n.size_flags_horizontal = align * 4 as Control.SizeFlags
	
	progress_bar.max_value = character.max_HP
	progress_bar.value = character.current_HP
	hp_label.text = str(character.current_HP, " / ", character.max_HP)
	
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
	color_me.append_array(fight_stuff)
	for node: Control in color_me:
		node.self_modulate = character.ui_color


func open_menu():
	buttons.visible = true
	cover.set("theme_override_styles/panel", PANEL_1)
	v_box_container.position = Vector2(0, 304)
	initial_button.grab_focus()


func _on_item_pressed():
	more_buttons.visible = true
	grid_container.items_setup()
func _on_fight_pressed():
	more_buttons.visible = true
	grid_container._on_move_button_pressed(character.attack)
func _on_magic_or_act_pressed():
	more_buttons.visible = true
	grid_container.magic_or_act_setup(character)
func _on_defend_pressed():
	more_buttons.visible = true
	grid_container._on_move_button_pressed(character.defend_move)
