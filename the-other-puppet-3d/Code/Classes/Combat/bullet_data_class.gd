class_name BulletData
extends Resource

@export var damage: int
@export var destroy_on_touch := false
@export var tension_points: int
@export var spawn_time: float
@export var spawn_coords: Vector2
@export_range(-360, 360, 0.1) var spawn_rotation: float = 0
@export var collision_shape: Shape2D
@export_flags_2d_physics var collision_layer: int
@export var sprite: Texture2D
@export_custom(PROPERTY_HINT_NONE, "suffix:seconds") var lasts_for: float
@export_category("Path")
@export var use_path := false
@export var path: Array[Vector2]
@export var speed: float
