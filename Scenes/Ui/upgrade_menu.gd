extends Control
signal resume


func _ready():
	TranslationServer.set_locale(Globals.current_language)
	translate()
func translate():
	%Continue.text= tr("continue")
	
#TODO pensar si poner las armas abajo a la derecha y mantener la ingame ui para ver las barras de vida.

func _on_continue_pressed():
	resume.emit()
