extends CharacterBody2D
class_name   PlayerParent

#TODO añadir estadísticas
#Components
@onready var hitbox_component =  %HitboxComponent as HitboxComponent
@onready var velocity_component =  %Velocity as VelocityComponent
@onready var health_component =  %HealthComponent as HealthComponent

var dead:bool = false
signal death

#Experience and gold
var experience = 0
var experience_level = 1
var collected_experience = 0
var gold = 0
var  collected_gold=0

#UI
@onready var expBar = get_node("/root/Level1/InGameUi/InGameUi/MarginContainer2/VBoxContainer/ProgressBar3")
@onready var expText = get_node("/root/Level1/InGameUi/InGameUi/MarginContainer2/VBoxContainer/ProgressBar3/Labelexp")
@onready var hpBar = get_node("/root/Level1/InGameUi/InGameUi/MarginContainer2/VBoxContainer/ProgressBar2")
@onready var hpText = get_node("/root/Level1/InGameUi/InGameUi/MarginContainer2/VBoxContainer/ProgressBar2/Label")


func _ready():
	%ProgressBar2.max_value = health_component.maxHealth
	%ProgressBar2.value = health_component.currentHealth

	print(health_component.currentHealth)
	print(health_component.maxHealth)
	hpBar.max_value = health_component.maxHealth
	hpBar.value = health_component.currentHealth

	hpText.text = str(health_component.currentHealth,"/",health_component.maxHealth)
func _physics_process(_delta):
	if dead:
			$AnimatedSprite2D.play('Death')
			get_parent().get_parent().get_node("GameOver").visible = true
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
	get_tree().change_scene_to_file("res://Scenes/Ui/main_menu.tscn")


func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self


func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collect()
		print(gem_exp)
		calculate_experience(gem_exp)
		area.queue_free()

func calculate_experience(gem_exp):
	var exp_required = calculate_experience_cap()
	collected_experience +=gem_exp
	if experience+ collected_experience >= exp_required: #level up
		collected_experience -=exp_required-experience
		experience_level+=1
		expText.text = str("Level ", experience_level)
		experience = 0
		exp_required = calculate_experience_cap()
		calculate_experience(0)
	else:
		experience+=collected_experience
		collected_experience = 0
	
	set_exp_bar(experience, calculate_experience_cap())

func calculate_experience_cap():
	var exp_cap = experience_level
	if experience_level <20:
		exp_cap = experience_level*5
	elif experience_level <40:
		exp_cap = 95 * (experience_level-19)*8
	else:
		exp_cap = 255 +(experience_level-39)*12
	return exp_cap

func set_exp_bar(set_value = 1, set_max_value = 100):
	expBar.value = set_value
	expBar.max_value = set_max_value
