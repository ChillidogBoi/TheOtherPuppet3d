extends Control

const MAIN_MENUS = preload("uid://b6v2srrg2bj40")
const VALID_SCREEN_SIZES = [
	Vector2i(640, 480), Vector2i(1280, 960), Vector2i(1920, 1080), Vector2(2560, 1920)
]

func _ready():
	var screen_size = DisplayServer.screen_get_size()
	var screen_pos = DisplayServer.screen_get_position()
	await RenderingServer.frame_post_draw
	var main_menu = MAIN_MENUS.instantiate()
	var final_size := Vector2i(640, 480)
	for new_size in VALID_SCREEN_SIZES:
		if screen_size.x > new_size.x and screen_size.y > new_size.y:
			final_size = new_size
	get_window().set("size", final_size)
	get_window().set("position", screen_pos + ((screen_size / 2) - (final_size / 2)))
	print(get_window().size)
	
	get_tree().change_scene_to_node(main_menu)
