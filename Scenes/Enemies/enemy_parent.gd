extends CharacterBody2D

class_name EnemyMeleeParent
#Componets
@onready var hitbox_component = %HitboxComponent as HitboxComponent
@onready var velocity_component = %Velocity as VelocityComponent
@onready var health_component = %HealthComponent as HealthComponent


var damage:float
#Exp and gold
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@export var experience: int
var exp_gem = preload("res://Scenes/objects/experience_gem.tscn")


func _ready():
	#$NavigationAgent2D.target_position = Globals.player_pos
	$AnimatedSprite2D.play("Run")



func _physics_process(_delta):
	#$NavigationAgent2D.target_position = Globals.player_pos
	if  Globals.player_pos.x< position.x:
		$AnimatedSprite2D.scale= Vector2(-1, 1)
	else:
		$AnimatedSprite2D.scale= Vector2(1, 1)
	#var next_path_position = $NavigationAgent2D.get_next_path_position()
	var direction: Vector2 = (Globals.player_pos - global_position).normalized()
	velocity = direction * velocity_component.base_mov_speed
	velocity_component.move(self)


func _on_health_component_dead():

	hitbox_component.disable_hitbox()
	velocity_component.stop_moving()
	$DamageAreaComponent/CollisionShape2D.disabled = true
	$AnimatedSprite2D.play('Death')


func _on_animated_sprite_2d_animation_finished():
	var new_gem = exp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.experience = experience
	loot_base.call_deferred("add_child", new_gem)
	queue_free()

#TODO el naivgationPath es un mierdón porque todos hacen siempre lo mismo y se stackean, probar si con usar direction del tirón funciona mejor
