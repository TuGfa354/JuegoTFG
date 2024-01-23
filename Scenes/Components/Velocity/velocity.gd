extends Node
class_name VelocityComponent

#region variables

@export var base_mov_speed: float
var velocity: Vector2 = Vector2.ZERO

#endregion





func move(body):
	velocity= body.velocity
	body.move_and_slide()
	velocity = body.velocity


func stop_moving():
	base_mov_speed = 0

