extends CharacterBody2D
class_name EnemyRangedParent
var player
var speed:int = 100
var attack_range:int = 200
var attacking:bool= false
signal spell(pos, direction)
var can_spell = true

func _ready():
	$NavigationAgent2D.target_position = Globals.player_pos
	$AnimatedSprite2D.play("Idle")

func _process(_delta):
	$NavigationAgent2D.target_position = Globals.player_pos
	if  Globals.player_pos.x< position.x:
		$AnimatedSprite2D.scale= Vector2(-1, 1)
	else:
		$AnimatedSprite2D.scale= Vector2(1, 1)
	var next_path_position = $NavigationAgent2D.get_next_path_position()
	var direction: Vector2 = (next_path_position - global_position).normalized()
	velocity = direction * speed

	var in_range: bool = Globals.player_pos.distance_to(global_position) < attack_range
	var pos: Vector2 = global_position
	if in_range:
		spellCast(pos,direction)
	else:
		$AnimatedSprite2D.play("Run")
		$AnimatedSprite2D.position = Vector2(0, -15)
		move_and_slide()

func spellCast(pos,direction):
	$AnimatedSprite2D.play("Idle")
	$AnimatedSprite2D.position = Vector2(0, 0)
	if can_spell:
		spell.emit(pos, direction)
		can_spell = false
		$Timers/SpellCooldDown.start()




func _on_spell_coold_down_timeout():
	can_spell = true
