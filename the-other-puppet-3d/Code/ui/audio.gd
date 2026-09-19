extends PanelContainer

@onready var music = $HBoxContainer/MusicVolume/SpinBox
@onready var sfx = $HBoxContainer/SFXVolume/SpinBox


func _on_music_up_pressed():
	if Settings.music_volume >= 100: return
	Settings.music_volume += 10
	music.value += 1
func _on_music_down_pressed():
	if Settings.music_volume <= 0: return
	Settings.music_volume -= 10
	music.value -= 1
func _on_music_changed(value):
	Settings.music_volume = value * 10


func _on_sfx_up_pressed():
	if Settings.sfx_volume >= 100: return
	Settings.sfx_volume += 10
	sfx.value += 1
func _on_sfx_down_pressed():
	if Settings.sfx_volume <= 0: return
	Settings.sfx_volume -= 10
	sfx.value -= 1
func _on_sfx_changed(value):
	Settings.sfx_volume = value * 10
