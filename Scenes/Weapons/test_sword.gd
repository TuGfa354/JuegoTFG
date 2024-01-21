extends ParentWeapon
signal attack(delta, direction, current_position, rotationdeg)

func _on_weapon_range_component_attack(delta, direction, current_position, rotationdeg):
	attack.emit(delta, direction, current_position, rotationdeg)


func _on_area_entered(area):
	if area is EnemyMeleeParent or EnemyRangedParent:
		$WeaponRangeComponent.travelled = true

