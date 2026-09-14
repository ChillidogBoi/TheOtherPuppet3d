extends Node

@export_range(0.0, 100.0) var music_volume: int = 100
@export_range(0.0, 100.0) var sfx_volume: int = 100

@export var invert_look_y: bool = false
@export var invert_look_x: bool = false

@export var mouse_sensitivity: float = 150.0 / pow(2, 16)
@export var controller_sensitivity: float = 200.0 / pow(2, 12)
