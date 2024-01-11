extends Control
signal resume
func _on_label_pressed():
	resume.emit()

func _ready():
	TranslationServer.set_locale(Globals.current_language)
	translate()
func translate():
	$HBoxContainer2/Continue.text = tr("continue")
