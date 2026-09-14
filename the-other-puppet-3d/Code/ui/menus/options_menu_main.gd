extends VBoxContainer

enum TABS {
	VIDEO,
	AUDIO,
	CONTROLS
}
@export var tabs: Array[Control] = []
@onready var v_slider = $Controls/VSlider

func _ready():
	change_to_tab(TABS.VIDEO, false)

func change_to_tab(tab:int, enter:bool = true):
	for n: int in tabs.size():
		if n != tab: tabs[n].visible = false
		else: tabs[n].visible = true
		
	if not enter: return
#	tabs[tab].find_next_valid_focus().grab_focus()

func _on_video_tab_pressed():
	change_to_tab(TABS.VIDEO)
func _on_audio_tab_pressed():
	change_to_tab(TABS.AUDIO)
func _on_controls_tab_pressed():
	v_slider.value = 0
	change_to_tab(TABS.CONTROLS)
