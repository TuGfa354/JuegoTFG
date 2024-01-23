extends Area2D
class_name HitboxComponent

#region variables

@export var health_component: HealthComponent
@export var hit_box_shape: CollisionShape2D
@export var timerDuration:float
var vulnerable = true
var areaframe
#endregion


func _ready():
	$Timer.wait_time = timerDuration

func disable_hitbox() -> void:
	hit_box_shape.set_deferred("disabled", true)

func enable_hitbox() -> void:
	hit_box_shape.set_deferred("disabled", false)

func _physics_process(_delta):
	if areaframe:
		if areaframe.overlaps_area(self):
			#if vulnerable:
				health_component.damage(areaframe.damage)
				#vulnerable = false
				#$Timer.start()

func _on_area_entered(area):
	if(area is ParentWeapon  or EnemyAttack or MeleeAttack or Attack):
		areaframe = area
		#if(area is EnemyAttack or Attack):
			#area.queue_free()
		#else:
			#pass
#TODO cuando haga las armas melee y funcionen como deberían quitar el timer que no hace nada
func _on_timer_timeout():
	#vulnerable = true
	pass


func _on_area_exited(area):
	if(area is ParentWeapon  or EnemyAttack or MeleeAttack or Attack):
		areaframe = null
