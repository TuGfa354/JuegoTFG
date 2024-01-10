extends Node
class_name VelocityComponent

@export var base_mov_speed: float
#@export var base_acceleration: float

var velocity: Vector2 = Vector2.ZERO
#var altering_mov_speed: float
#var altering_acceleration: float


#func _ready():
	##altering_mov_speed = base_mov_speed
	#pass


func move(body):
	velocity= body.velocity
	body.move_and_slide()

	velocity = body.velocity


func stop_moving():
	base_mov_speed = 0



#func start_moving():
	#altering_mov_speed = base_mov_speed
	#pass
