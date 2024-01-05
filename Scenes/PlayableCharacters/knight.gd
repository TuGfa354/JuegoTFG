extends PlayerParent
signal attack(delta, direction, current_position, rotationdeg)




func _on_test_sword_attack(delta, direction, current_position, rotationdeg):
	attack.emit(delta, direction, current_position, rotationdeg)
