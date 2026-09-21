extends Control

@onready var load_pattern = $LoadPattern
var pattern_filepath: String
var presets: UserPresets
@onready var errors = $Errors

func _ready():
	if ResourceLoader.exists("user://presets.res"):
		presets = ResourceLoader.load("user://presets.res")
		pattern_filepath = presets.starting_directory
		return
	
	pattern_filepath = OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS)
	presets = UserPresets.new()
	presets.starting_directory = pattern_filepath
	ResourceSaver.save(presets, "user://presets.res")

func _on_upload_pressed():
	load_pattern.set_current_dir(pattern_filepath)
	load_pattern.visible = true

func _on_create_pressed():
	pass # Replace with function body.

func _on_dir_selected(dir):
	pattern_filepath = dir

func _on_load_pattern_file_selected(path):
	presets.starting_directory = pattern_filepath
	ResourceSaver.save(presets, "user://presets.res")
	
	if not ResourceLoader.exists(path):
		cool_push_error(str("Error: \"", path, "\" is not a valid FanDeltaGodot bullet pattern"))
		return
	var loaded_thing = ResourceLoader.load(path)
	if not loaded_thing is BulletPatternData:
		cool_push_error(str("Error:\n \"", path, "\"\nis not a valid FanDeltaGodot bullet pattern"))
		return
	
	LoadedThings.current_bullet_pattern = loaded_thing

func cool_push_error(error: String):
	errors.text = error
	await get_tree().create_timer(5.0).timeout
	if errors.text == error: errors.text = ""
