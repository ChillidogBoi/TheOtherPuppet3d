class_name Bullet
extends AnimatableBody2D

@export_range(-360, 360, 0.1) var spawn_rotation: float
@export var damage: int
@export var tension_points: int
@export var destroy_on_touch := false
@export var collision_shape: Shape2D
@export var sprite: Texture2D
@export_custom(PROPERTY_HINT_NONE, "suffix:seconds") var lasts_for: float

@export_category("Path")
@export var use_path := false
@export var path: Array[Vector2]
@export var speed: float

var timer: Timer
var fired := false
var next_point: Vector2

func fire():
	if spawn_rotation != rotation:
		rotation = deg_to_rad(spawn_rotation)
	print(rotation)
	if use_path and path.size() > 0: next_point = path.pop_front()
	fired = true
	var col := CollisionShape2D.new()
	add_child(col)
	col.shape = collision_shape
	var spr := Sprite2D.new()
	add_child(spr)
	spr.texture = sprite
	
	timer = Timer.new()
	add_child(timer)
	timer.start(lasts_for)
	await timer.timeout
	queue_free()

func _physics_process(delta):
	if not use_path or not fired: return
	if position == next_point:
		if path.size() == 0: return
		next_point = path.pop_front()
	if position.distance_to(next_point) < speed:
		position = next_point
		return
	position = position.move_toward(next_point, speed)
	
	
