extends Node3D

@onready var loading_screen = $LoadingScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	loading_screen.play_backwards("fade_in")
