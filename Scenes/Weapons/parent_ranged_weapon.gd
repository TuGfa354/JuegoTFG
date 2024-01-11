extends Area2D
class_name ParentRangedWeapon
var can_shoot:bool = true
@export var range_area:float
@export var attack_speed:float
@export var damage:float
func _ready():
	$CollisionShape2D.shape.radius = range_area
	%Timer.wait_time = attack_speed
func _physics_process(_delta):
	var enemies_in_range = get_overlapping_areas()
	if enemies_in_range.size() > 0:
		var distances= []
		for target_enemy in enemies_in_range:
			distances.append(global_position.distance_to(target_enemy.global_position))
		var target_enemy = enemies_in_range[distances.find(distances.min())]
		look_at(target_enemy.global_position)
		if can_shoot:
			shoot()

func shoot():
	const BULLET = preload("res://Scenes/Projectiles/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position =%ShootingPoint.global_position
	new_bullet.global_rotation =%ShootingPoint.global_rotation

	new_bullet.damage = damage
	get_node("/root/Level1/Projectiles").add_child(new_bullet)
	can_shoot = false
	%Timer.start()

func _on_timer_timeout():
	can_shoot = true
