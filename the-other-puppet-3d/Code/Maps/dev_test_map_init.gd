extends Node3D

@onready var loading_screen = $LoadingScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	await RenderingServer.frame_post_draw
	loading_screen.get_child(0).visible = false
