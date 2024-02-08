extends Area2D
class_name Attack
var travelled_distance:float = 0
var damage:float
var life_steal:float

func _physics_process(delta):
	const SPEED :int =750
	const RANGE = 10000
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travelled_distance+=SPEED*delta
	if travelled_distance>RANGE:
		queue_free()


func _on_body_entered(_body):
	queue_free()


func _on_area_entered(area):
	print(area, area.health_component.currentHealth)
	queue_free()
