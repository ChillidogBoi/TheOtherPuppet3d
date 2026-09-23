extends Area3D

const SPEED = 9.5
@onready var mesh_instance_3d = $CollisionShape3D/MeshInstance3D
@onready var cpu_particles_3d = $CPUParticles3D
@onready var timer = $Timer


func _physics_process(delta):
	var move_by = (global_transform.basis * Vector3.FORWARD) * SPEED * delta
	global_position += move_by
	
	if timer.is_stopped(): this_is_the_end()


func _on_body_entered(body):
	if body is CharacterBody3D: return
	if body.collision_layer & 0b10:
		if body.has_method("q_free"): body.q_free()
		else: body.queue_free()
	
	this_is_the_end()


func this_is_the_end():
	mesh_instance_3d.visible = false
	cpu_particles_3d.emitting = true
	await get_tree().create_timer(cpu_particles_3d.lifetime).timeout
	queue_free()
