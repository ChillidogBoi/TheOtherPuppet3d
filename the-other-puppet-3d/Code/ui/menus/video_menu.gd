extends VBoxContainer

@onready var window_size_label = $WindowSize/Label

const VALID_SCREEN_SIZES = [
	Vector2i(640, 480), Vector2i(1280, 960), Vector2i(1920, 1440),
	Vector2(2560, 1920), Vector2i(3200, 2400), Vector2i(3840, 2880),
	Vector2i(4480, 3360)
]
const VALID_SCREEN_SIZE_NAMES = [
	"Native", "fake HD", "1440p", "2k", "3k", "4k"
]
var current: int = 0

func _on_window_size_pressed():
	current = (current + 1) % VALID_SCREEN_SIZES.size()
	var new_size =  VALID_SCREEN_SIZES[current]
	
	var screen_size = DisplayServer.screen_get_size()
	var screen_pos = DisplayServer.screen_get_position()
	if screen_size.x > new_size.x and screen_size.y > new_size.y:
		get_window().set("size", new_size)
		get_window().set("position", screen_pos + ((screen_size / 2) - (new_size / 2)))
	else:
		current = -1
		_on_window_size_pressed()
