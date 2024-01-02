extends Node2D
class_name ParentLevel
var spell_scene: PackedScene = preload("res://Scenes/Projectiles/spell.tscn")






func _on_knight_death():
	%GameOver.visible = true


func _on_pause_menu_pause(visible):
	print("a")
	print (visible)
	$CanvasLayer.visible = visible
