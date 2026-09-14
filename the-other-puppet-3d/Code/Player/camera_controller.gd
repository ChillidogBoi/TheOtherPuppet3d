extends Node3D

const MAX_HEIGHT_DIST = Vector2(-1.5, 1.0)
@export_range(0.0, 1.0, 0.001) var lerp_by: float = 0.5
@export var body: CharacterBody3D = null

var body_last_pos : Vector3

func _ready():
	body_last_pos = global_position
	assert(body != null, "Exported variable \"body\" not initialized to type \"CharacterBody3D\"")

func _physics_process(delta):
	var body_cur_pos = Vector3(body.global_position.x, 0, body.global_position.z)
	# give some leeway to the height
	body_cur_pos.y = clamp(global_position.y,
		body.global_position.y + MAX_HEIGHT_DIST.x, body.global_position.y + MAX_HEIGHT_DIST.y)
	# apply
	global_position = lerp(global_position, body_cur_pos, 0.25)
	
	var input = Input.get_vector("look_left", "look_right", "look_down", "look_up")
	if input.length() == 0: return
	do_camera_move(input, true)

func _unhandled_input(event):
	if not event is InputEventMouseMotion: return
	
	var move_by: Vector2 = event.screen_relative
	do_camera_move(move_by)

func do_camera_move(move_by: Vector2, is_controller: bool = false):
	var sens: float = -Settings.mouse_sensitivity
	if is_controller: sens = -Settings.controller_sensitivity
	
	var inversion = Vector2(float(Settings.invert_look_x), float(Settings.invert_look_y))
	inversion = (inversion - Vector2(0.5, 0.5)) * -2
	
	body.rotate_y(move_by.x * sens * inversion.x)
	rotate_y(move_by.x * sens * inversion.x)
