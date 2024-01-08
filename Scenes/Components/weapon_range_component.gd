extends Area2D
class_name WeaponRangeComponent
@export var range_area:float
@export var attack_speed:float
var can_attack:bool = true
var travelled:bool = false
var collisionShape
var travelled_distance:float
var initial_position:Vector2
var areaframe: Area2D
var direction
var level
var weapon
var weapons
var current_position
signal attack(delta, direction, travelled_distance, current_position, initial_position, rotationdeg, range_area)
signal sword_back()
func _ready():
	$AttackCooldown.wait_time=attack_speed
	collisionShape = get_child(1)
	collisionShape.shape.radius = range_area
	initial_position = get_parent().position
	level= get_node("/root/Level1")
	weapon = get_parent()
	weapons = get_node("/root/Level1/Character/Knight/Weapons")



func _physics_process(delta):
	var enemies_in_range = get_overlapping_areas()
	if enemies_in_range.size() > 0:
		var aa = areaframe.global_position
		direction = (aa- global_position).normalized()
		var rotationdeg = rad_to_deg(direction.angle()) + 90
		get_parent().rotation_degrees = rotationdeg
		if can_attack:
			current_position = get_parent().global_position
			if get_parent().get_parent()==level:
				#This directions in a oneshot
				var direction2 =(aa- global_position).normalized()
				attacka(delta, direction2)
			else:
				if get_tree().get_nodes_in_group("Weapons").size() ==1:
					attack.emit(delta, direction, current_position, rotationdeg)
					weapon.visible = false
					weapon.get_child(0).set_deferred("disabled", true)


#func sword_back_function():
	#$AttackCooldown.start()

	
func attacka(delta, direction2):
	const SPEED :float = 100
	get_parent().global_position += direction2 * SPEED * delta
	travelled_distance+=SPEED*delta
	if travelled or travelled_distance>=range_area:
		get_node("/root/Level1/Character/Knight/Weapons/TestSword").visible = true
		get_node("/root/Level1/Character/Knight/Weapons/TestSword").get_child(0).set_deferred("disabled", false)
		get_node("/root/Level1/Character/Knight/Weapons/TestSword").get_child(3).get_child(0).start()
		get_node("/root/Level1/Character/Knight/Weapons/TestSword").get_child(3).can_attack = false
		get_parent().queue_free()





func _on_attack_cooldown_timeout():

	#get_node("/root/Level1/Character/Knight/Weapons/TestSword").global_position = initial_position
	get_node("/root/Level1/Character/Knight/Weapons/TestSword").get_child(3).can_attack = true
	




func _on_area_entered(area):
	areaframe = area




func _on_area_exited(_area):
	pass
