extends Area2D
class_name WeaponRangeComponent
@export var range_area:float
@export var attack_speed:float
var can_attack:bool = true

var collisionShape
var travelled_distance:float
var initial_position:Vector2
var areaframe: Area2D
var direction
var level
var weapon
var weapons
var current_position

func _ready():
	$AttackCooldown.wait_time=attack_speed
	collisionShape = get_child(1)
	collisionShape.shape.radius = range_area
	initial_position = get_parent().position
	level= get_parent().get_parent().get_parent().get_parent().get_parent()
	weapon = get_parent()
	weapons = get_parent().get_parent()
	print("level", level,"weapon", weapon, "character", weapons)
func _physics_process(delta):
	var enemies_in_range = get_overlapping_areas()
	if enemies_in_range.size() > 0:
		var aa = areaframe.global_position
		direction = (aa- global_position).normalized()
		get_parent().rotation_degrees = rad_to_deg(direction.angle()) + 90
		if can_attack:
			attack(delta)



func attack(delta):
	current_position = get_parent().global_position
	
	const SPEED :float =500
	move_sword()
	get_parent().global_position += direction * SPEED * delta
	travelled_distance+=SPEED*delta
	if travelled_distance>range_area:
		print("a")
		can_attack = false
		travelled_distance = 0
		$AttackCooldown.start()
		level.remove_child(weapon)
		weapons.add_child(weapon)
		weapon.position = initial_position


#IDEA, HACERLA INVISIBLE E INSTANCIARLA 

func move_sword():
		weapons.remove_child(weapon)
		level.add_child(weapon)
		var final_number=level.get_children().size()-1
		level.get_child(final_number).global_position = current_position

func _on_attack_cooldown_timeout():
	
	can_attack = true




func _on_area_entered(area):
	areaframe = area
	print(areaframe)




func _on_area_exited(_area):
	pass
