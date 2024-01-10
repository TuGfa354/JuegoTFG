extends Control
@onready var menu =$Menu
@onready var options = $Options
@onready var video = $Video
@onready var audio = $Audio
@onready var languages_drop_down = $Options/VBoxContainer/HBoxContainer/OptionButton
#TODO Import the language from a save file so that u only change it the first time u open it
func _ready():
	add_languages()
	TranslationServer.set_locale(Globals.current_language)
	translate()
	$Menu/Start.grab_focus()
func translate():
		$Menu/Start.text = tr("start")
		$Menu/Options.text = tr("options")
		$Menu/Exit.text = tr("exit")
		$Options/VBoxContainer/Video.text = tr("video")
		$Options/VBoxContainer/Audio.text= tr("audio")
		$Options/VBoxContainer/HBoxContainer/Language.text= tr("language")
		languages_drop_down.set_item_text(0,tr("english"))
		languages_drop_down.set_item_text(1,tr("spanish"))
		$Options/BackFromOptions.text= tr("back")
		$Video/HBoxContainer/Labels/FullScreen.text= tr("fullscreen")
		$Video/HBoxContainer/Labels/Borderless.text= tr("borderless")
		$Video/HBoxContainer/Labels/VSync.text= tr("vsync")
		$Video/BackFromVideo.text= tr("back")
		$Audio/HBoxContainer/Labels/Master.text= tr("master")
		$Audio/HBoxContainer/Labels/Music.text= tr("music")
		$"Audio/HBoxContainer/Labels/Sound FX".text= tr("sound FX")
		$Audio/BackFromAudio.text= tr("back")
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()
func add_languages():
	languages_drop_down.add_item("english",0)
	languages_drop_down.add_item("spanish",1)

func toggle():
	visible = !visible
	get_tree().paused = visible

func show_and_hide(first, second):
	first.show()
	second.hide()

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)

#region Signals


func _on_start_pressed():
	toggle()
	#TODO, mirar tutorial asíncrono para cambiar escenas
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_options_pressed():
	show_and_hide(options, menu)
	$Options/VBoxContainer/Video.grab_focus()


func _on_exit_pressed():
	get_tree().quit()

func _on_video_pressed():
	show_and_hide(video, options)
	$Video/HBoxContainer/Checks/Fullscreen.grab_focus()

func _on_audio_pressed():
	show_and_hide(audio, options)
	$Audio/HBoxContainer/Slider/Master.grab_focus()

func _on_back_from_options_pressed():
	show_and_hide(menu, options)
	$Menu/Start.grab_focus()

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
	show_and_hide(options, video)
	$Options/VBoxContainer/Video.grab_focus()

func _on_back_from_audio_pressed():
	show_and_hide(options, audio)
	$Options/VBoxContainer/Audio.grab_focus()


func _on_master_value_changed(value):
	volume(0, value)


func _on_music_value_changed(value):
	volume(1, value)


func _on_sound_fx_value_changed(value):
	volume(2, value)


func _on_option_button_item_selected(index):
	if index==0:
		TranslationServer.set_locale("en")
		Globals.current_language = "en"
		translate()
	else:
		TranslationServer.set_locale("es")
		Globals.current_language = "es"
		translate()

#endregion
