class_name Bullet
extends AnimatableBody2D

@export var collision_shape: Shape2D
@export var sprite: Texture2D
@export_custom(PROPERTY_HINT_NONE, "suffix:seconds") var lasts_for: float

@export_category("Path")
@export var use_path := false
@export var path: Array[Vector2]
@export var speed: float

var timer: Timer
var fired := false

func fire():
	fired = true
	var col := CollisionShape2D.new()
	add_child(col)
	col.shape = collision_shape
	var spr := Sprite2D.new()
	add_child(spr)
	spr.texture = sprite
	
	timer = Timer.new()
	timer.start(lasts_for)
	await timer.timeout
	queue_free()

func _physics_process(delta):
	if not use_path or not fired: return
	var next_point: Vector2 = path.pop_front()
	if position.distance_to(next_point) < speed:
		position = next_point
		return
	position = position.move_toward(next_point, speed)
