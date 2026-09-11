extends Control

const MAIN_MENUS = preload("uid://b6v2srrg2bj40")

func _ready():
	await get_tree().create_timer(0).timeout
	get_tree().change_scene_to_packed(MAIN_MENUS)
