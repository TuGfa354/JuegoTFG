extends CharacterBody2D

class_name EnemyMeleeParent
var damaging : bool = false
var player

var speed: int  = 125
func _ready():
	$NavigationAgent2D.target_position = Globals.player_pos
	$AnimatedSprite2D.play("Run")

func _process(_delta):
	$NavigationAgent2D.target_position = Globals.player_pos
	if  Globals.player_pos.x< position.x:
		$AnimatedSprite2D.scale= Vector2(-1, 1)
	else:
		$AnimatedSprite2D.scale= Vector2(1, 1)
	var next_path_position = $NavigationAgent2D.get_next_path_position()
	var direction: Vector2 = (next_path_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	if  damaging:
		if "hit" in player:
			player.hit()



func _on_hit_area_body_entered(body):
	damaging = true
	player = body

func _on_hit_area_body_exited(body):
	damaging = false
	player = body
