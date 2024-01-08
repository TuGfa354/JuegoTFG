extends Area2D
class_name  EnemyAttack
var direction: Vector2
var damage:int

func _physics_process(delta):
	const SPEED: int = 100
	damage = 30
	position += direction * SPEED * delta


func _on_body_entered(body):
	queue_free()
