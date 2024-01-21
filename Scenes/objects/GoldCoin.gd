extends Area2D

@export var gold = 1

var spr_1 = preload("res://Graphics/Kyrise's 16x16 RPG Icon Pack - V1.3/icons/48x48/coin_01d.png")
var spr_2 = preload("res://Graphics/Kyrise's 16x16 RPG Icon Pack - V1.3/icons/48x48/coin_02d.png")
var spr_3 = preload("res://Graphics/Kyrise's 16x16 RPG Icon Pack - V1.3/icons/48x48/coin_03d.png")

var target = null
var speed = 7

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _ready():
	if gold == 1:
		return
	elif gold == 2:
		sprite.texture= spr_2
	else:
		sprite.texture = spr_3

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 15*delta

func collect():
	$AudioStreamPlayer.play()
	collision.call_deferred("set","disabled", true)
	sprite.visible = false
	return gold


func _on_audio_stream_player_finished():
	queue_free()
