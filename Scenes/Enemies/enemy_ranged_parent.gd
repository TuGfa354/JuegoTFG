extends CharacterBody2D
class_name EnemyRangedParent


@onready var hitbox_component = %HitboxComponent as HitboxComponent
@onready var velocity_component = %Velocity as VelocityComponent
@onready var health_component = %HealthComponent as HealthComponent
@onready var damage_range_component = %DamageRangeComponent as DamageRangeComponent
var direction: Vector2
var running:bool = true
var SPEED: float
var dead:bool = false


func _ready():
	$NavigationAgent2D.target_position = Globals.player_pos
	$AnimatedSprite2D.play("Run")
	SPEED = velocity_component.base_mov_speed



func _physics_process(_delta):
	if dead:
		$AnimatedSprite2D.play('Death')
	else:
		$NavigationAgent2D.target_position = Globals.player_pos
		if  Globals.player_pos.x< position.x:
			$AnimatedSprite2D.scale= Vector2(-1, 1)
		else:
			$AnimatedSprite2D.scale= Vector2(1, 1)
		var next_path_position = $NavigationAgent2D.get_next_path_position()
		direction = (next_path_position - global_position).normalized()
		velocity = direction * velocity_component.base_mov_speed
		if running:
			velocity_component.base_mov_speed = SPEED
			$AnimatedSprite2D.play("Run")
			$AnimatedSprite2D.position = Vector2(0,0)
			velocity_component.move(self)
		else:
			$AnimatedSprite2D.play("Idle")
			$AnimatedSprite2D.position = Vector2(0,15)
			velocity_component.stop_moving()



func _on_animated_sprite_2d_animation_finished():
	queue_free()


func _on_health_component_dead():

	hitbox_component.disable_hitbox()
	velocity_component.stop_moving()
	damage_range_component.queue_free()
	dead = true
