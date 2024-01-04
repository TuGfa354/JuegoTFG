extends Area2D
class_name   Attack
var direction: Vector2
var damage:float



func _physics_process(delta):
	const SPEED: float = 100
	damage = 30
	position += direction * SPEED * delta


func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()
