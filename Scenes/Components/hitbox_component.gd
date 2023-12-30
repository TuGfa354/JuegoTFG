extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent
@export var hit_box_shape: CollisionShape2D
@export var timerDuration:float
var vulnerable = true
var areaframe
#func _on_body_entered(body):
	#print(body)
	#if(body is EnemyMeleeParent):
		#health_component.damage(body.damage)

func _ready():
	$Timer.wait_time = timerDuration
func disable_hitbox() -> void:
	hit_box_shape.set_deferred("disabled", true)


func enable_hitbox() -> void:
	hit_box_shape.set_deferred("disabled", false)

func _process(delta):
	if areaframe:
		if areaframe.overlaps_area(self):
			if vulnerable:
				print(Time.get_datetime_dict_from_system())
				health_component.damage(areaframe.damage)
				vulnerable = false
				$Timer.start()

func _on_area_entered(area):
	if(area is ParentWeapon  or Attack or MeleeAttack):
		areaframe = area

func _on_timer_timeout():
	vulnerable = true


func _on_area_exited(area):
	if(area is ParentWeapon  or Attack or MeleeAttack):
		areaframe = null
