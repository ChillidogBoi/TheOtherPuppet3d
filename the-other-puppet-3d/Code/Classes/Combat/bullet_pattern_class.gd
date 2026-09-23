class_name BulletPattern
extends Node2D

signal gained_tp(amount: int)
signal took_damage(damage: int)
signal ended
const SOUL = preload("uid://cnegr5g8s8vo3")
var player: CharacterBody2D = null


const BULLET_VARS = [
	"collision_shape", "sprite", "lasts_for", "use_path", "path", "speed",
	"collision_layer", "damage", "destroy_on_touch", "spawn_rotation",
	"tension_points"
]

@export var bullets: Array[BulletData]
@export var start_after: float
@export var end_time: float = 10

var current_bullet: int = 0
var time_passed: float = 0
var playing := false


func _ready():
	current_bullet = 0
	playing = true
	
	await get_tree().create_timer(start_after).timeout
	player = SOUL.instantiate()
	add_child(player)

func _physics_process(delta):
	if not playing: return
	
	time_passed += delta
	
	if time_passed > end_time:
		ended.emit()
		playing = false
		return
	
	if bullets.size() - 1 < current_bullet: return
	if bullets[current_bullet].spawn_time > time_passed: return
	
	var new_bullet = Bullet.new()
	new_bullet.position = bullets[current_bullet].spawn_coords
	add_child(new_bullet)
	for n in BULLET_VARS:
		new_bullet.set(n, bullets[current_bullet].get(n))
	new_bullet.fire()
	current_bullet += 1
