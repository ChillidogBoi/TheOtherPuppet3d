extends StaticBody3D

@onready var cpu_particles_3d = $CPUParticles3D
@onready var mesh_instance_3d = $MeshInstance3D


func q_free():
	cpu_particles_3d.emitting = true
	mesh_instance_3d.visible = false
	await get_tree().create_timer(cpu_particles_3d.lifetime).timeout
	queue_free()
