extends Node2D
class_name ParentLevel
var sword:PackedScene = preload("res://Scenes/Weapons/test_sword.tscn")
signal sword_back
func _ready():
	$InGameUi/InGameUi/MarginContainer/VBoxContainer/Timer.text= str($Enemies/EnemySpawner.total_time)
	$InGameUi/InGameUi/MarginContainer/VBoxContainer/HBoxContainer/WaveNumber.text= str($Enemies/EnemySpawner.wave)

func _on_pause_menu_pause(visible2):
	$CanvasLayer.visible = visible2
	$CanvasLayer/ColorRect2/PauseMenu/Menu/Start.grab_focus()


func _on_knight_attack(delta, direction, current_position, rotationdeg):
	if get_tree().get_nodes_in_group("Weapons").size() ==1:
		var new_weapon = sword.instantiate()
		new_weapon.global_position = current_position
		new_weapon.rotation_degrees = rotationdeg
		self.add_child(new_weapon)
		new_weapon.get_child(3).attacka(delta, direction)


func _on_enemy_spawner_wave_ended():
	$UpgradeMenu.visible = !$UpgradeMenu.visible
	#$InGameUi.visible = !$InGameUi.visible
	$InGameUi/InGameUi/MarginContainer/VBoxContainer/Timer.visible = !$InGameUi/InGameUi/MarginContainer/VBoxContainer/Timer.visible
	
	$UpgradeMenu/UpgradeMenu/Continue.grab_focus()
	for i in $Enemies/EnemySpawner/enemies.get_children():
		i.queue_free()
	for i in $Loot.get_children():
		i.queue_free()
	for i in $Projectiles.get_children():
		i.queue_free()
	get_tree().paused = $UpgradeMenu.visible
	$InGameUi/InGameUi/MarginContainer/VBoxContainer/HBoxContainer/WaveNumber.text= str($Enemies/EnemySpawner.wave)



func _on_upgrade_menu_resume():
	$UpgradeMenu.visible = !$UpgradeMenu.visible
	$InGameUi/InGameUi/MarginContainer/VBoxContainer/Timer.visible = !$InGameUi/InGameUi/MarginContainer/VBoxContainer/Timer.visible
	get_tree().paused = $UpgradeMenu.visible
	$InGameUi/InGameUi/MarginContainer/VBoxContainer/Timer.text= str($Enemies/EnemySpawner.total_time)
	$Enemies/EnemySpawner.time = 1
	
