extends Node
class_name HealthComponent

#region signals

signal dead
signal damaged(damage_amount)
signal healed(healing_amount)
#endregion
#region variables

var vulnerable:bool = true
@export var maxHealth: float

var currentHealth
#endregion



func _ready():
	if(maxHealth == 0):
		printerr("Did not set health for " + owner.name)
		return
	
	currentHealth = maxHealth




func damage(damage_amount: float):
#Character has slight invulnerability every time it gets hit
	if get_parent() is PlayerParent:
		if vulnerable:
			currentHealth = maxf(0.0, currentHealth - damage_amount)
			vulnerable = false
			$Timer.start()
			#Updates the UI values
			get_parent().get_node("ProgressBar2").value = currentHealth
			get_node("/root/Level1/InGameUi/InGameUi/MarginContainer2/VBoxContainer/ProgressBar2").value = currentHealth
			get_node("/root/Level1/InGameUi/InGameUi/MarginContainer2/VBoxContainer/ProgressBar2/Label").text = str(currentHealth,"/",maxHealth)
			#Shows hp bar on character if not full hp
			if get_parent().get_node("ProgressBar2").value == get_parent().get_node("ProgressBar2").max_value:
				get_parent().get_node("ProgressBar2").visible = false
			else:
				get_parent().get_node("ProgressBar2").visible = true
	else:
		#Enemies don't have a vulnerable timer, melee weapons do on their damage
		currentHealth = maxf(0.0, currentHealth - damage_amount)

	if(currentHealth == 0):
		dead.emit()




func heal(heal_amount: float):
	currentHealth = minf(maxHealth, currentHealth + heal_amount)
	healed.emit(heal_amount)


func _on_timer_timeout():
	vulnerable = true
