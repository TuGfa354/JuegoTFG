extends CharacterBody2D
class_name   PlayerParent
var speed: int = 200
var dead : bool = false


func movementInput():
	
	if Input.is_action_pressed("Down") or Input.is_action_pressed("Right") or Input.is_action_pressed("Left") or Input.is_action_pressed("Up"):
		$AnimatedSprite2D.play("Run")
		$AnimatedSprite2D.position = Vector2(0, -15)
		if Input.is_action_just_pressed("Left"):
			$AnimatedSprite2D.scale= Vector2(-1, 1)
		if Input.is_action_just_pressed("Right"):
			$AnimatedSprite2D.scale= Vector2(1, 1)
		var direction = Input.get_vector("Left", "Right", "Up", "Down")
		velocity = direction * speed
		move_and_slide()
		Globals.player_pos = global_position
	else:
		$AnimatedSprite2D.play("Idle")
		$AnimatedSprite2D.position = Vector2(0, 0)

func hit():
	Globals.hp -= 10
	if Globals.hp == 0:
		dead = true
		$AnimatedSprite2D.play('Death')
