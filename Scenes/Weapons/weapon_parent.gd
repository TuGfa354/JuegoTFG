extends Node2D
class_name ParentWeapon
var damage:int
var attacking: bool = false
var player
#var attack_speed:int
#var can_attack:bool



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attacking:
		if "hit" in player:
			player.hit(damage)


func _on_body_entered(body):
	attacking = true
	print("attacking")
	player = body


func _on_body_exited(body):
	attacking = false
	player = body
