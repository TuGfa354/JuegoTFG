extends Node
class_name HealthComponent

signal dead
signal damaged(damage_amount)
signal healed(healing_amount)

@export var maxHealth: float

var currentHealth



func _ready():
	if(maxHealth == 0):
		printerr("Did not set health for " + owner.name)
		return
	
	currentHealth = maxHealth



func damage(damage_amount: float):

	currentHealth = maxf(0.0, currentHealth - damage_amount)
	if get_parent() is PlayerParent:
		get_parent().get_node("ProgressBar").value = currentHealth
	if(currentHealth == 0):

		dead.emit()




func heal(heal_amount: float):
	currentHealth = minf(maxHealth, currentHealth + heal_amount)
	healed.emit(heal_amount)
