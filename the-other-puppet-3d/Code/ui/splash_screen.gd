extends Control

@onready var loading_screen = $LoadingScreen


func _ready():
	loading_screen.play("fade_in")
	await loading_screen.animation_finished
	
	var MAIN_MENUS = load("uid://b6v2srrg2bj40")
	var main_menu = MAIN_MENUS.instantiate()
	get_tree().change_scene_to_node(main_menu)
