class_name BulletData
extends Resource

const COPY_VARS = [
	"collision_shape", "sprite", "lasts_for", "use_path", "path", "speed", "collision_layer", "damage"
]

@export var spawn_time: float
@export var spawn_coords: Vector2
@export var collision_shape: Shape2D
@export_flags_2d_physics var collision_layer: int
@export var sprite: Texture2D
@export var damage: int
@export_custom(PROPERTY_HINT_NONE, "suffix:seconds") var lasts_for: float
@export_category("Path")
@export var use_path := false
@export var path: Array[Vector2]
@export var speed: float
