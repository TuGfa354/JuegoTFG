extends PlayerParent
signal attack(delta, direction, travelled_distance, current_position, initial_position, rotationdeg, range_area)




func _on_test_sword_attack(delta, direction, travelled_distance, current_position, initial_position, rotationdeg, range_area):
	attack.emit(delta, direction, travelled_distance, current_position, initial_position, rotationdeg, range_area)
