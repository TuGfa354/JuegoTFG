extends Node
signal stat_change



var hp: int = 60:
	set(value):
		if value > hp:
			hp = min(value, 100)
		else:
			if player_vulnerable:
				hp = value
				player_vulnerable = false
				player_invulnerable_timer()
		stat_change.emit()
		

func player_invulnerable_timer():
	await get_tree().create_timer(0.2,).timeout
	player_vulnerable = true


var player_pos : Vector2
var player_vulnerable: bool = true
