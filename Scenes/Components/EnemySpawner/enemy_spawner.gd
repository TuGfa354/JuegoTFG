extends Node2D
#region signals

signal wave_ended

#endregion
#region variables
#Custom resource
@export var spawns: Array[SpawnInfo]= []
@onready var player = get_tree().get_first_node_in_group("Player")
var time = 0
var total_time= 20
var wave:int = 1
#endregion



func _on_timer_timeout():
	print(time)
	time+=1
	get_node("/root/Level1/InGameUi/InGameUi/MarginContainer/VBoxContainer/Timer").text = str(total_time-time)
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if wave == i.wave:
			if time>= i.time_start and time <= i.time_end:
				if i.spawn_delay_counter < i.enemy_spawn_delay:
					i.spawn_delay_counter +=1
				else:
					i.spawn_delay_counter = 0
					var new_enemy = load(str(i.enemy.resource_path))
					var counter = 0
					while counter<i.enemy_number:
						var enemy_spawn = new_enemy.instantiate()
						enemy_spawn.global_position = get_random_position()
						$enemies.add_child(enemy_spawn)
						counter+=1
		elif wave>i.wave:
			spawns.erase(i)
	if time==total_time:
		wave+=1
		wave_ended.emit()


func get_random_position():
	#Corners positions
	#var top_left = Vector2(60,60)
	#var top_right = Vector2(1880,60)
	#var bottom_right= Vector2(1880,1000)
	#var bottom_left = Vector2(60,1000)
	#var pos_side = ["up", "down","right","left"].pick_random()
	#var spawn_pos1 = Vector2.ZERO
	#var spawn_pos2 = Vector2.ZERO
	#match pos_side:
		#"up":
			#spawn_pos1=top_left
			#spawn_pos2=top_right
		#"down":
			#spawn_pos1=bottom_left
			#spawn_pos2=bottom_right
		#"right":
			#spawn_pos1=top_right
			#spawn_pos2=bottom_right
		#"left":
			#spawn_pos1=top_left
			#spawn_pos2=bottom_left
	#Picks random position between two corners
	var x_spawn = randf_range(60, 1880)
	var y_spawn = randf_range(60, 1000)
	return Vector2(x_spawn, y_spawn)
	#IN A CIRCLE OR SOMETHING
	#var vpr = get_viewport_rect().size
	#var bottom_right_corner = Vector2(vpr.x/2, vpr.y/2)
	#var radius = Vector2.ZERO.distance_to(bottom_right_corner) * randf_range(1.1,1.4)
	#var angle = randf_range(0, 2*PI)
	#return Vector2(radius, 0).rotated(angle)
