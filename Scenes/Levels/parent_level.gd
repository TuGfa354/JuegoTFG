extends Node2D
class_name ParentLevel
var sword:PackedScene = preload("res://Scenes/Weapons/test_sword.tscn")
signal sword_back
	
func _on_pause_menu_pause(visible2):
	$CanvasLayer.visible = visible2
	$CanvasLayer/ColorRect2/PauseMenu/Menu/Start.grab_focus()


func _on_knight_attack(delta, direction, travelled_distance, current_position, initial_position, rotationdeg, range_area):
	if get_tree().get_nodes_in_group("Weapons").size() ==1:
		var new_weapon = sword.instantiate()
		new_weapon.global_position = current_position
		new_weapon.rotation_degrees = rotationdeg
		self.add_child(new_weapon)
		new_weapon.get_child(3).attacka(delta, direction)
