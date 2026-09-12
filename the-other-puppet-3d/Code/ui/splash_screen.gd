extends Control

const MAIN_MENUS = preload("uid://b6v2srrg2bj40")

func _ready():
	await RenderingServer.frame_post_draw
	var main_menu = MAIN_MENUS.instantiate()
	get_tree().change_scene_to_node(main_menu)
