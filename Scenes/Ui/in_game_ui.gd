extends Control
func _ready():
	TranslationServer.set_locale(Globals.current_language)
	translate()
func translate():
	%Wave.text = tr("wave")

