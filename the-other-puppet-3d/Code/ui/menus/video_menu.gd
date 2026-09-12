extends VBoxContainer

@onready var window_size_label: Label = $WindowSize/Label

const VALID_SCREEN_SIZES = [
	Vector2i(640, 480), Vector2i(1280, 960), Vector2i(1920, 1440),
	Vector2(2560, 1920), Vector2i(3200, 2400), Vector2i(3840, 2880),
	Vector2i(4480, 3360)
]
const VALID_SCREEN_SIZE_NAMES = [
	"Native", "2x Native", "3x Native", "4x Native", "5x Native", "Fullscreen"
]
var current: int = 0
var current_window: Window

func _ready():
	window_size_label.text = VALID_SCREEN_SIZE_NAMES[
		VALID_SCREEN_SIZES.find(DisplayServer.screen_get_size())
	]
	current_window = get_window()


func _process(delta):
	if not Input.is_action_just_pressed("toggle_fullscreen"): return
	if current_window.mode == Window.MODE_WINDOWED:
		current = -1
		current_window.size = DisplayServer.screen_get_size()
		current_window.mode = Window.MODE_FULLSCREEN
		window_size_label.text = VALID_SCREEN_SIZE_NAMES[current]
		return
	current = 0
	current_window.size = VALID_SCREEN_SIZES[current]
	current_window.mode = Window.MODE_WINDOWED
	window_size_label.text = VALID_SCREEN_SIZE_NAMES[current]


func _on_window_size_pressed():
	current_window.mode = Window.MODE_WINDOWED
	current = (current + 1) % VALID_SCREEN_SIZES.size()
	var new_size =  VALID_SCREEN_SIZES[current]
	
	var screen_size = DisplayServer.screen_get_size()
	var screen_pos = DisplayServer.screen_get_position()
	if screen_size.x > new_size.x and screen_size.y > new_size.y:
		current_window.size = new_size
		current_window.position = screen_pos + ((screen_size / 2) - (new_size / 2))
	else:
		current = -1
		current_window.size = screen_size
		current_window.mode = Window.MODE_FULLSCREEN
	
	window_size_label.text = VALID_SCREEN_SIZE_NAMES[current]
