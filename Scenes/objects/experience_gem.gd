extends Area2D

@export var experience = 1

var spr_green = preload("res://Graphics/Kyrise's 16x16 RPG Icon Pack - V1.3/icons/48x48/gem_01a.png")
var spr_yellow = preload("res://Graphics/Kyrise's 16x16 RPG Icon Pack - V1.3/icons/48x48/gem_01b.png")
var spr_red = preload("res://Graphics/Kyrise's 16x16 RPG Icon Pack - V1.3/icons/48x48/gem_01d.png")

var target = null
var speed = 7

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _ready():
	if experience == 1:
		return
	elif experience == 2:
		sprite.texture= spr_yellow
	else:
		sprite.texture = spr_red

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 15*delta

func collect():
	$AudioStreamPlayer.play()
	collision.call_deferred("set","disabled", true)
	sprite.visible = false
	return experience


func _on_audio_stream_player_finished():
	queue_free()
