extends CharacterBody2D
class_name   PlayerParent

@onready var hitbox_component =  %HitboxComponent as HitboxComponent
@onready var velocity_component =  %Velocity as VelocityComponent
@onready var health_component =  %HealthComponent as HealthComponent
var dead:bool = false
func _process(delta):
	if dead:
			$AnimatedSprite2D.play('Death')
	else:
		if Input.is_action_pressed("Down") or Input.is_action_pressed("Right") or Input.is_action_pressed("Left") or Input.is_action_pressed("Up"):
			$AnimatedSprite2D.play("Run")
			$AnimatedSprite2D.position = Vector2(0, -15)
			if Input.is_action_just_pressed("Left"):
				$AnimatedSprite2D.scale= Vector2(-1, 1)
			if Input.is_action_just_pressed("Right"):
				$AnimatedSprite2D.scale= Vector2(1, 1)
			var direction = Input.get_vector("Left", "Right", "Up", "Down")
			velocity = direction * velocity_component.base_mov_speed
			velocity_component.move(self)
			Globals.player_pos = global_position
		else:
			$AnimatedSprite2D.play('Idle')
			$AnimatedSprite2D.position = Vector2(0, 0)


func _on_health_component_dead():
	hitbox_component.disable_hitbox()
	velocity_component.stop_moving()
	dead = true




func _on_animated_sprite_2d_animation_finished():
	get_tree().free()
