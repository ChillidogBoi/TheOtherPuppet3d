extends Node3D

const MAX_LOOK_DIRS = Vector2(-0.25, 0.75)
const BULLET_COOLDOWN = 0.25
const PLAYER_BULLET = preload("uid://b16ys4dce0v47")
const MAX_HEIGHT_DIST = Vector2(-1.5, 1.0)
@export_range(0.0, 1.0, 0.001) var lerp_by: float = 0.5
@export var body: CharacterBody3D = null
@export var bullet_timer: Timer
@export var target_ray: RayCast3D
@export var spring_arm: SpringArm3D
@export var camera: Camera3D

var body_last_pos : Vector3

func _ready():
	body_last_pos = global_position
	assert(body != null, "Exported variable \"body\" not initialized to type \"CharacterBody3D\"")
	target_ray.add_exception(body)

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"): try_bullet_spawn()
	
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
	do_camera_move(event.screen_relative)

func try_bullet_spawn():
	if not bullet_timer.is_stopped(): return
	bullet_timer.start(BULLET_COOLDOWN)
	var new_bullet: Area3D = PLAYER_BULLET.instantiate()
	
	var targ
	if target_ray.is_colliding(): targ = target_ray.get_collision_point()
	else: targ = target_ray.to_global(target_ray.target_position)
	var new_transform: Transform3D = body.global_transform
	new_transform.origin.y += 1
	
	add_child(new_bullet)
	spring_arm.add_excluded_object(new_bullet.get_rid())
	new_bullet.global_transform = new_transform
	new_bullet.look_at(targ)
	print(targ)

func do_camera_move(move_by: Vector2, is_controller: bool = false):
	var sens: float = -Settings.mouse_sensitivity
	if is_controller: sens = -Settings.controller_sensitivity
	
	var inversion = Vector2(float(Settings.invert_look_x), float(Settings.invert_look_y))
	inversion = (inversion - Vector2(0.5, 0.5)) * -2
	
	move_by *= sens * inversion
	
	move_by.y = clamp(
		camera.rotation.x + move_by.y,
		MAX_LOOK_DIRS.x,
		MAX_LOOK_DIRS.y
	) - camera.rotation.x
	
	body.rotate_y(move_by.x)
	rotate_y(move_by.x)
	
	camera.rotate_x(move_by.y)
