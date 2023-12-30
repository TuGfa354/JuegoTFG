extends CharacterBody2D

class_name EnemyMeleeParent
@onready var hitbox_component = %HitboxComponent as HitboxComponent
@onready var velocity_component = %Velocity as VelocityComponent
@onready var health_component = %HealthComponent as HealthComponent
var damage:float


func _ready():
	$NavigationAgent2D.target_position = Globals.player_pos
	$AnimatedSprite2D.play("Run")



func _process(delta):
	$NavigationAgent2D.target_position = Globals.player_pos
	if  Globals.player_pos.x< position.x:
		$AnimatedSprite2D.scale= Vector2(-1, 1)
	else:
		$AnimatedSprite2D.scale= Vector2(1, 1)
	var next_path_position = $NavigationAgent2D.get_next_path_position()
	var direction: Vector2 = (next_path_position - global_position).normalized()
	velocity = direction * velocity_component.base_mov_speed
	velocity_component.move(self)


func _on_health_component_dead():

	hitbox_component.disable_hitbox()
	velocity_component.stop_moving()
	$AnimatedSprite2D.play('Death')
