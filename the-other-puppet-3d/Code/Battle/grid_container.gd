extends GridContainer

signal input_yes
signal target_button_pressed(selection: Combatant)
const MENU_BUTTON = preload("uid://c0u5nb8ob0god")
@onready var color_rect = $"../.."
@onready var fight_stuff = $"../../../ColorRect2"
@onready var fight_anim = $"../../../ColorRect2/AnimationPlayer"
@onready var item_button = $"../../../Buttons/HBoxContainer/Item"
@onready var fight = $"../../../Buttons/HBoxContainer/Fight"

func _input(event):
	if not event.is_pressed(): return
	if not event is InputEventKey: return
	if InputMap.action_has_event("jump", event):
		fight_anim.animation_finished.emit()
	if InputMap.action_has_event("ui_cancel", event):
		target_button_pressed.emit(null)

func magic_or_act_setup(who: Combatant):
	setup_buttons(who.spells_or_acts, "display_name", _on_move_button_pressed)

func items_setup():
	setup_buttons(Party.items, "display_name", _on_move_button_pressed)
	
	var new_size = round(Party.items.size() / 2.0) * 35
	if new_size > 105: color_rect.custom_minimum_size.y = new_size
	else: color_rect.custom_minimum_size.y = 106


func _on_move_button_pressed(move:BattleMove):
	var targ = null
	var tim: float = 1.0
	if move.targets_who == 0 or move.targets_who == 2:
		targ = await decide_target()
		if targ == null:
			color_rect.visible = false
			fight.grab_focus()
			return
	if move.requires_timing: tim = await get_timing()
	print(tim)
	move.execute(targ, tim)


func decide_target(target_party_mem := false) -> Combatant:
	if target_party_mem: setup_buttons(Party.party, "display_name", target_button_pressed.emit)
	else: setup_buttons(Party.enemy_party, "display_name", target_button_pressed.emit)
	
	var ans = await target_button_pressed
	color_rect.visible = false
	
	if ans is bool: return null
	return ans

func setup_buttons(from: Array, name_var: String, connect_to: Callable):
	for c in get_children():
		c.queue_free()
	var last_button: Button = null
	for n in from:
		var new_button = MENU_BUTTON.instantiate()
		add_child(new_button)
		var op_button = new_button.find_child("Button")
		if last_button != null:
			last_button.focus_neighbor_right = last_button.get_path_to(op_button)
			op_button.focus_neighbor_left = op_button.get_path_to(last_button)
		new_button.find_child("Label").text = n.get(name_var).capitalize()
		
		last_button = op_button
		last_button.pressed.connect(connect_to.bind(n))
	
	get_child(0).grab_focus()


func get_timing() -> float:
	fight_anim.play("RESET")
	fight_stuff.visible = true
	fight_anim.play("attack_timing")
	await fight_anim.animation_finished
	var t = 1 - abs(0.75 - fight_anim.current_animation_position) - 0.5
	fight_stuff.visible = false
	return (t / fight_anim.current_animation_length) * 10
	
