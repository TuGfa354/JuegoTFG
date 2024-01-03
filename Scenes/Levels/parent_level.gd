extends Node2D
class_name ParentLevel
var spell_scene: PackedScene = preload("res://Scenes/Projectiles/spell.tscn")

func _on_pause_menu_pause(visible2):
	$CanvasLayer.visible = visible2
	$CanvasLayer/ColorRect2/PauseMenu/Menu/Start.grab_focus()
