extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent
@export var hit_box_shape: CollisionShape2D
var areaframe
#func _on_body_entered(body):
	#print(body)
	#if(body is EnemyMeleeParent):
		#health_component.damage(body.damage)

func disable_hitbox() -> void:
	hit_box_shape.set_deferred("disabled", true)


func enable_hitbox() -> void:
	hit_box_shape.set_deferred("disabled", false)

func _process(delta):
	if areaframe:
		if areaframe.overlaps_area(self):
			health_component.damage(areaframe.damage)

func _on_area_entered(area):
	if(area is ParentWeapon  or Attack or MeleeAttack):
		print(area.get_parent() , "damaged")
		areaframe = area


