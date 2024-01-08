extends Area2D
class_name Attack
var travelled_distance:float = 0
var damage:float

func _physics_process(delta):
	const SPEED :int =100
	const RANGE = 1200
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travelled_distance+=SPEED*delta
	if travelled_distance>RANGE:
		queue_free()


func _on_body_entered(body):
	queue_free()
