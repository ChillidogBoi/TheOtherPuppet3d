extends GridContainer

const MENU_BUTTON = preload("uid://c0u5nb8ob0god")

func _ready():
	for n in Party.items:
		var new_button = MENU_BUTTON.instantiate()
		add_child(new_button)
		new_button.find_child("Label").text = n.get_method().capitalize()
		new_button.find_child("Button").pressed.connect(n)
