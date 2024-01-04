extends Node2D
class_name ParentLevel
#var test_sword:PackedScene = preload("res://Scenes/Weapons/test_sword.tscn")
#@onready var marker = $Character/Knight.get_child(1).get_child(0).global_position
#
#func _ready():
	#print(marker)
	#var sword =test_sword.instantiate()
	#sword.global_position = marker
	#add_child(sword)
	#print(sword.global_position)
func _on_pause_menu_pause(visible2):
	$CanvasLayer.visible = visible2
	$CanvasLayer/ColorRect2/PauseMenu/Menu/Start.grab_focus()
