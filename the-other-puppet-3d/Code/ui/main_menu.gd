extends ColorRect

@export var initial_button: Button
@export var loading_screen: AnimationPlayer
@export var transitions: AnimationPlayer

@export_category("")
@export var main_buttons: Array[Button]

@onready var options = $"../Options"


func _process(delta):
	if not Input.is_action_just_pressed("pause_(menu)"): return
	
	if not options.visible: return
	transitions.play_backwards("main -> options")
	initial_button.grab_focus()

func _ready():
	await RenderingServer.frame_post_draw
	assert(loading_screen != null, "Exported variable \"loading_screen\" not initialized to type \"AnimationPlayer\"")
	loading_screen.get_child(0).visible = false
	assert(initial_button != null, "Exported variable \"initial_button\" not initialized to type \"Button\"")
	initial_button.grab_focus()


func _on_options_pressed():
	transitions.play("main -> options")
	main_buttons[2].get_node(main_buttons[2].focus_next).grab_focus()
	for n in main_buttons:
		n.disabled = true


func _on_button_mouse_entered():
	if not options.visible: return
	transitions.play_backwards("main -> options")


func _on_play_pressed():
	loading_screen.get_child(0).visible = true
	var new_scene: Node = load("uid://bijidkcfh2r6h").instantiate()
	get_tree().change_scene_to_node(new_scene)
