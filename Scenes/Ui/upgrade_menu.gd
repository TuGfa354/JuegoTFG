extends Control
signal resume
func _on_label_pressed():
	resume.emit()
