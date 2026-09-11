extends VBoxContainer

enum TABS {
	VIDEO,
	AUDIO,
	CONTROLS
}
@export var tabs: Array[Control] = []

func _ready():
	change_to_tab(TABS.VIDEO)

func change_to_tab(tab:int):
	for n: int in tabs.size():
		if n != tab: tabs[n].visible = false
		else: tabs[n].visible = true

func _on_video_tab_pressed():
	change_to_tab(TABS.VIDEO)
func _on_audio_tab_pressed():
	change_to_tab(TABS.AUDIO)
func _on_controls_tab_pressed():
	change_to_tab(TABS.CONTROLS)
