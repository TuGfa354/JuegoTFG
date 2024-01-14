extends Control
@onready var menu = %Menu
@onready var options = %OptionsMenu
@onready var video = %VideoMenu
@onready var audio = %AudioMenu
@onready var languages_drop_down = %OptionButton
@onready var fullscreen_checkbox=%FullscreenCheckbox
@onready var borderless_checkbox=%BorderlessCheckbox
@onready var vSyncfullscreen_checkbox=%VSyncCheckbox
@onready var master_bar = %MasterBar
@onready var master_text = %MasterBarLabel
@onready var music_bar = %MusicBar
@onready var music_text = %MusicBarLabel
@onready var sound_bar = %"Sound FXBar"
@onready var sound_text = %"Sound FXBarLabel"
#TODO Import the language from a save file so that u only change it the first time u open it
func _ready():
	add_languages()
	TranslationServer.set_locale(Globals.current_language)
	translate()
	%Start.grab_focus()
	#fullscreen_checkbox.button_pressed = Globals.fullscreen
	#borderless_checkbox.button_pressed = Globals.borderless
	#vSyncfullscreen_checkbox.button_pressed = Globals.vsync
	master_bar.value = Globals.master_sound
	master_text.text = str(Globals.master_sound)
	music_bar.value = Globals.music_sound
	music_text.text = str(Globals.music_sound)
	sound_bar.value = Globals.fx_sound
	sound_text.text = str(Globals.fx_sound)
	
	
func translate():
		%Start.text = tr("start")
		%Options.text = tr("options")
		%Exit.text = tr("exit")
		%Video.text = tr("video")
		%Audio.text= tr("audio")
		%Language.text= tr("language")
		languages_drop_down.set_item_text(0,tr("english"))
		languages_drop_down.set_item_text(1,tr("spanish"))
		%BackFromOptions.text= tr("back")
		%FullScreen.text= tr("fullscreen")
		%Borderless.text= tr("borderless")
		%VSync.text= tr("vsync")
		%BackFromVideo.text= tr("back")
		%Master.text= tr("master")
		%Music.text= tr("music")
		%"Sound FX".text= tr("sound FX")
		%BackFromAudio.text= tr("back")

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
	%Video.grab_focus()
	print(Globals.current_language)
	if Globals.current_language =="es":
		languages_drop_down.selected = 1
	else:
		languages_drop_down.selected = 0


func _on_exit_pressed():
	get_tree().quit()

func _on_video_pressed():
	show_and_hide(video, options)
	%FullscreenCheckbox.grab_focus()

func _on_audio_pressed():
	show_and_hide(audio, options)
	%MasterBar.grab_focus()

func _on_back_from_options_pressed():
	show_and_hide(menu, options)
	%Start.grab_focus()
#TODO exclusive fullscreen no significa borderless, es el fullscreen que hay que usar para que se adapte a las resoluciones
#si no es fullscreen que sea ventana y que borderless sea independiente, descomentar lo del ready y en el futuro hacer que sea con el guardado o algo
#Repetir lo mismo en pause menu
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
	%Video.grab_focus()

func _on_back_from_audio_pressed():
	show_and_hide(options, audio)
	%Audio.grab_focus()


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
