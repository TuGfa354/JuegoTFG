extends Node
class_name HealthComponent

signal dead
signal damaged(damage_amount)
signal healed(healing_amount)

@export var maxHealth: float
@export var timerDuration:float
var currentHealth
var vulnerable = true


func _ready():
	if(maxHealth == 0):
		printerr("Did not set health for " + owner.name)
		return
	
	currentHealth = maxHealth
	$Timer.wait_time = timerDuration



func damage(damage_amount: float):
	if vulnerable:
		print("vulnerable")
		currentHealth = maxf(0.0, currentHealth - damage_amount)
		print (currentHealth)
		if(currentHealth == 0):
			dead.emit()
		else:
			vulnerable = false
			$Timer.start()


func heal(heal_amount: float):
	currentHealth = minf(maxHealth, currentHealth + heal_amount)
	healed.emit(heal_amount)


func _on_timer_timeout():
	vulnerable = true
