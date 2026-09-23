extends RayCast3D

@onready var shadow = $Shadow


func _physics_process(delta):
	if is_colliding():
		shadow.global_position = get_collision_point() + Vector3(0, 0.005, 0)
		shadow.global_basis.y = get_collision_normal()
