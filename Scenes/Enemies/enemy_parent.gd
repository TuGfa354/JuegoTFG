extends CharacterBody2D

class_name EnemyMeleeParent

#region variables

#Components
@onready var hitbox_component = %HitboxComponent as HitboxComponent
@onready var velocity_component = %Velocity as VelocityComponent
@onready var health_component = %HealthComponent as HealthComponent


#Exp and gold
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@export var experience: int
var exp_gem = preload("res://Scenes/objects/experience_gem.tscn")
var gold_coin = preload("res://Scenes/objects/gold_coin.tscn")
@export var gold:int
#endregion


func _ready():
	$AnimatedSprite2D.play("Run")



func _physics_process(_delta):
	if  Globals.player_pos.x< position.x:
		$AnimatedSprite2D.scale= Vector2(-1, 1)
	else:
		$AnimatedSprite2D.scale= Vector2(1, 1)
	var direction: Vector2 = (Globals.player_pos - global_position).normalized()
	velocity = direction * velocity_component.base_mov_speed
	velocity_component.move(self)


func _on_health_component_dead():
	hitbox_component.disable_hitbox()
	velocity_component.stop_moving()
	#Stops doing damage when the death animations is playing
	$DamageAreaComponent/CollisionShape2D.disabled = true
	$AnimatedSprite2D.play('Death')


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


