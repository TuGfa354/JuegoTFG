extends Control
signal resume


func _ready():
	TranslationServer.set_locale(Globals.current_language)
	translate()
func translate():
	%Continue.text= tr("continue")
	%Buy.text = tr("buy")
	%Buy2.text = tr("buy")
	%Buy3.text = tr("buy")
	%Objects.text = tr("objects")
	%Weapons.text = tr("weapons")
	%Reroll.text = tr("reroll")
#TODO pensar si poner las armas abajo a la derecha y mantener la ingame ui para ver las barras de vida.

func _on_continue_pressed():
	resume.emit()
