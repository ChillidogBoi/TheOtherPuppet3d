class_name BulletPattern
extends Node2D

signal ended

const BULLET_VARS = [
	"collision_shape", "sprite", "lasts_for", "use_path", "path", "speed", "collision_layer"
]

class BulletData:
	extends Resource
	@export var spawn_time: float
	@export var spawn_coords: Vector2
	@export var collision_shape: Shape2D
	@export_flags_2d_physics var collision_layer: int
	@export var sprite: Texture2D
	@export_custom(PROPERTY_HINT_NONE, "suffix:seconds") var lasts_for: float
	@export_category("Path")
	@export var use_path := false
	@export var path: Array[Vector2]
	@export var speed: float

@export var bullets: Array[BulletData]
# -1 means wait until the animation is finished
@export var end_time: float = -1

var current_bullet: int = 0
var timer: Timer

func _ready():
	current_bullet = 0
	timer = Timer.new()
	if end_time < 0: timer.start(2147483645)
	else: timer.start(end_time)
	
	play_pattern()

func play_pattern():
	var time_passed: float = timer.wait_time - timer.time_left
	if bullets.size() > current_bullet:
		if bullets[current_bullet].spawn_time <= time_passed:
			var new_bullet = Bullet.new()
			add_child(new_bullet)
			for n in BULLET_VARS:
				new_bullet.set(n, bullets[current_bullet].get(n))
			new_bullet.position = bullets[current_bullet].spawn_coords
			new_bullet.fire()
			current_bullet += 1
	
	if timer.time_left == 0:
		ended.emit()
		return
	if end_time < 0 and bullets.size() == current_bullet and get_child_count() == 0:
		ended.emit()
		return
	
	play_pattern()
