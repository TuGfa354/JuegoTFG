extends Control
@onready var menu =$Menu
@onready var options = $Options
@onready var video = $Video
@onready var audio = $Audio
signal pause
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()

func toggle():
	visible = !visible
	get_tree().paused = visible
	pause.emit(visible)

func show_and_hide(first, second):
	first.show()
	second.hide()

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)
func _on_start_pressed():
	toggle()



func _on_options_pressed():
	show_and_hide(options, menu)


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Scenes/Ui/main_menu.tscn")

func _on_video_pressed():
	show_and_hide(video, options)

func _on_audio_pressed():
	show_and_hide(audio, options)

func _on_back_from_options_pressed():
	show_and_hide(menu, options)

func _on_fullscreen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_borderless_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_v_sync_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_back_from_video_pressed():
	show_and_hide(menu, video)

func _on_back_from_audio_pressed():
	show_and_hide(menu, audio)


func _on_master_value_changed(value):
	volume(0, value)


func _on_music_value_changed(value):
	volume(1, value)


func _on_sound_fx_value_changed(value):
	volume(2, value)
