extends CharacterBody2D
class_name EnemyRangedParent

#region variables

#Components
@onready var hitbox_component = %HitboxComponent as HitboxComponent
@onready var velocity_component = %Velocity as VelocityComponent
@onready var health_component = %HealthComponent as HealthComponent
@onready var damage_range_component = %DamageRangeComponent as DamageRangeComponent

var direction: Vector2
var running:bool = true
var SPEED: float
var dead:bool = false

#Exp and gold
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@export var experience: int
var exp_gem = preload("res://Scenes/objects/experience_gem.tscn")
var gold_coin = preload("res://Scenes/objects/gold_coin.tscn")
@export var gold:int
#endregion

func _ready():
	$AnimatedSprite2D.play("Run")
	SPEED = velocity_component.base_mov_speed

#TODO mejorar la muerte como con el melee

func _physics_process(_delta):
	if dead:
		$AnimatedSprite2D.play('Death')
	else:
		if  Globals.player_pos.x< position.x:
			$AnimatedSprite2D.scale= Vector2(-1, 1)
		else:
			$AnimatedSprite2D.scale= Vector2(1, 1)
		direction = (Globals.player_pos - global_position).normalized()
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
	#Experience
	var new_gem = exp_gem.instantiate()
	new_gem.global_position = Vector2(global_position.x-10,global_position.y)
	new_gem.experience = experience
	loot_base.call_deferred("add_child", new_gem)
	#Gold
	var new_coin = gold_coin.instantiate()
	new_coin.global_position = Vector2(global_position.x+10,global_position.y)
	new_coin.gold = gold
	loot_base.call_deferred("add_child", new_coin)
	queue_free()


func _on_health_component_dead():

	hitbox_component.disable_hitbox()
	velocity_component.stop_moving()
	damage_range_component.queue_free()
	dead = true
