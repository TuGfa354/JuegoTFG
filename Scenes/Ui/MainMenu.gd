extends Control
@onready var menu =$Menu
@onready var options = $Options
@onready var video = $Video
@onready var audio = $Audio
@onready var languages_drop_down = $Options/VBoxContainer/HBoxContainer/OptionButton
@onready var fullscreen_checkbox=$Video/HBoxContainer/Checks/Fullscreen
@onready var borderless_checkbox=$Video/HBoxContainer/Checks/Borderless
@onready var vSyncfullscreen_checkbox=$Video/HBoxContainer/Checks/VSync
@onready var master_bar = $Audio/HBoxContainer/Slider/HBoxContainer/Master
@onready var master_text = $Audio/HBoxContainer/Slider/HBoxContainer/Label
@onready var music_bar = $Audio/HBoxContainer/Slider/HBoxContainer2/Music
@onready var music_text = $Audio/HBoxContainer/Slider/HBoxContainer2/Label
@onready var sound_bar = $"Audio/HBoxContainer/Slider/HBoxContainer3/Sound FX"
@onready var sound_text = $Audio/HBoxContainer/Slider/HBoxContainer3/Label
#TODO Import the language from a save file so that u only change it the first time u open it
func _ready():
	add_languages()
	TranslationServer.set_locale(Globals.current_language)
	translate()
	$Menu/Start.grab_focus()
	fullscreen_checkbox.button_pressed = Globals.fullscreen
	borderless_checkbox.button_pressed = Globals.borderless
	vSyncfullscreen_checkbox.button_pressed = Globals.vsync
	master_bar.value = Globals.master_sound
	master_text.text = str(Globals.master_sound)
	music_bar.value = Globals.music_sound
	music_text.text = str(Globals.music_sound)
	sound_bar.value = Globals.fx_sound
	sound_text.text = str(Globals.fx_sound)
	
	
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
	print(Globals.current_language)
	if Globals.current_language =="es":
		languages_drop_down.selected = 1
	else:
		languages_drop_down.selected = 0


func _on_exit_pressed():
	get_tree().quit()

func _on_video_pressed():
	show_and_hide(video, options)
	$Video/HBoxContainer/Checks/Fullscreen.grab_focus()

func _on_audio_pressed():
	show_and_hide(audio, options)
	$Audio/HBoxContainer/Slider/HBoxContainer/Master.grab_focus()

func _on_back_from_options_pressed():
	show_and_hide(menu, options)
	$Menu/Start.grab_focus()

func _on_fullscreen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Globals.fullscreen = true
		Globals.borderless = false
		borderless_checkbox.button_pressed= Globals.borderless
		
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		Globals.fullscreen = false
		Globals.borderless = true
		borderless_checkbox.button_pressed= Globals.borderless

func _on_borderless_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		Globals.borderless = true
		Globals.fullscreen = false
		fullscreen_checkbox.button_pressed = Globals.fullscreen
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Globals.borderless = false
		Globals.fullscreen = true
		fullscreen_checkbox.button_pressed = Globals.fullscreen

func _on_v_sync_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		Globals.vsync = true
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		Globals.vsync = false

func _on_back_from_video_pressed():
	show_and_hide(options, video)
	$Options/VBoxContainer/Video.grab_focus()

func _on_back_from_audio_pressed():
	show_and_hide(options, audio)
	$Options/VBoxContainer/Audio.grab_focus()


func _on_master_value_changed(value):
	volume(0, value)
	Globals.master_sound = value
	master_text.text = str(Globals.master_sound)

func _on_music_value_changed(value):
	volume(1, value)
	Globals.music_sound = value
	music_text.text = str(Globals.music_sound)


func _on_sound_fx_value_changed(value):
	volume(2, value)
	Globals.fx_sound = value
	sound_text.text= str(Globals.fx_sound)


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
