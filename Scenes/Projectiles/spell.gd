extends Area2D
class_name   MeleeAttack
@export var speed: int = 100
var damage: int = 10
var direction: Vector2 = Vector2.UP

func _ready():
	pass

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()
