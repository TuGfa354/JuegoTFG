extends Area2D
class_name ParentRangedWeapon

#region variables


var can_shoot:bool = true

@export var weapon_info = WeaponInfo
@export var range_area:float
@export var attack_speed:float
@export var damage:float 
@export var life_steal:float
#@export var weapon_name:String
#@export var price:int
#var description:String
#@export var level:int = 1
#@onready var image = $WeaponPivot/Sprite2D
#endregion
#TODO añadir más stats y/o escalados
func _ready():
	$CollisionShape2D.shape.radius = range_area
	#range_area = weapon_info.range_area
	#attack_speed = weapon_info.attack_speed
	#damage = weapon_info.damage
	%Timer.wait_time = attack_speed
	#var description_text = "Fires a bullet to enemies with a range of %.1f every %.1f seconds that deals %.1f damage"
	#description = description_text % [range_area, attack_speed, damage]
	#print(description)
func _physics_process(_delta):
	var enemies_in_range = get_overlapping_areas()
	if enemies_in_range.size() > 0:
		var distances= []
		#Finds the enemy that's closest to the gun
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
	new_bullet.life_steal = life_steal
	get_node("/root/Level1/Projectiles").add_child(new_bullet)
	can_shoot = false
	%Timer.start()

func _on_timer_timeout():
	can_shoot = true
