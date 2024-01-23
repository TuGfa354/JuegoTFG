extends Area2D
class_name DamageRangeComponent

#region signals

signal casting
signal not_casting
#endregion

#region variables

var in_range:bool = false
var can_cast:bool = true
@export var timerDuration:float
#endregion

func _ready():
	$SpellCooldown.wait_time = timerDuration

func _physics_process(_delta):
	var pos = get_parent().global_position
	var direction = get_parent().direction
	if in_range:
		get_parent().running = false
		if can_cast:
			cast_spell(pos, direction)
	else:

		get_parent().running = true

func cast_spell(pos, direction):
	var spell = preload("res://Scenes/Projectiles/spell.tscn").instantiate() as Area2D
	spell.position = pos
	spell.rotation_degrees = rad_to_deg(direction.angle()) + 90
	spell.direction = direction
	get_node("/root/Level1/Projectiles").add_child(spell)
	can_cast=false
	$SpellCooldown.start()

func _on_body_entered(body):
	if(body is PlayerParent):
		in_range = true



func _on_body_exited(_body):
	in_range = false



func _on_spell_cooldown_timeout():
	can_cast = true
