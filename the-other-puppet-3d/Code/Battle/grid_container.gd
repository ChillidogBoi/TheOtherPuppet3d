extends GridContainer

const MENU_BUTTON = preload("uid://c0u5nb8ob0god")
@onready var color_rect = $"../.."

func items_setup():
	var last_button: Button = null
	for n in Party.items:
		var new_button = MENU_BUTTON.instantiate()
		add_child(new_button)
		var op_button = new_button.find_child("Button")
		if last_button != null:
			last_button.focus_neighbor_right = last_button.get_path_to(op_button)
			op_button.focus_neighbor_left = op_button.get_path_to(last_button)
		new_button.find_child("Label").text = n.get_method().capitalize()
		
		last_button = op_button
		last_button.pressed.connect(n.execute)
	
	var new_size = round(Party.items.size() / 2.0) * 35
	if new_size > 105: color_rect.custom_minimum_size.y = new_size
	else: color_rect.custom_minimum_size.y = 106

func _on_move_button_pressed(move:BattleMove):

	move.execute()
