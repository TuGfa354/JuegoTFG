extends CharacterBody2D

class_name EnemyMeleeParent
var attacking : bool = false
var hp:int = 50
var player
var vulnerable: bool = true
var dead:bool = false

var speed: int  = 125
func _ready():
	$NavigationAgent2D.target_position = Globals.player_pos
	$AnimatedSprite2D.play("Run")

func _process(_delta):
	if dead:
		$AnimatedSprite2D.play('Death')
	else:
		$NavigationAgent2D.target_position = Globals.player_pos
		if  Globals.player_pos.x< position.x:
			$AnimatedSprite2D.scale= Vector2(-1, 1)
		else:
			$AnimatedSprite2D.scale= Vector2(1, 1)
		var next_path_position = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		if  attacking:
			if "hit" in player:
				
				player.hit()



func _on_damage_area_body_entered(body):
	attacking = true
	player = body

func _on_damage_area_body_exited(body):
	attacking = false
	player = body

func hit(damage):
	if vulnerable:
		hp -= damage
		vulnerable = false
		$Timers/VulnerableCooldown.start()
		if hp <= 0:
			dead = true


func _on_vulnerable_cooldown_timeout():
	vulnerable = true


func _on_animated_sprite_2d_animation_finished():
	queue_free()
