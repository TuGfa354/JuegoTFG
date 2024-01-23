extends Control
signal resume
@export var weapons: Array[PackedScene]= []
var player_gold:int 

func _ready():
	
	TranslationServer.set_locale(Globals.current_language)
	translate()
func translate():
	%Continue.text= tr("continue")
	%Buy.text = tr("buy")
	%Buy2.text = tr("buy")
	%Buy3.text = tr("buy")
	%Objects.text = tr("objects")
	%Weapons.text = tr("weapons")
	%Reroll.text = tr("reroll")
#func _process(delta):
	#print(visible)

func _on_continue_pressed():
	resume.emit()

#TODO cuando le doy a la derecha en el ccandado de la derecha me lleva a reroll, cuando le doy a reroll a la izq mme lleva a la llave
#TODO cambiar las stats a botones para poder leer lo que hacen


func _on_visibility_changed():
	if get_parent().visible == true:
		player_gold = get_tree().get_first_node_in_group("player").gold
		update_money()
		store_roll()

func store_roll():
	var weapon_1 = weapons.pick_random().instantiate()
	var weapon_2 = weapons.pick_random().instantiate()
	var weapon_3 = weapons.pick_random().instantiate()
	print(weapon_1.description)
	print(weapon_2.description)
	print(weapon_3.description)
	%Item1.texture = weapon_1.image
	%Item2.texture = weapon_2.image
	%Item3.texture = weapon_3.image
	%ItemDescription1.text = weapon_1.description
	%ItemDescription2.text = weapon_2.description
	%ItemDescription3.text = weapon_3.description
	%Price1.text = str(weapon_1.price)
	%Price2.text = str(weapon_2.price)
	%Price3.text = str(weapon_3.price)
	%ItemName1.text = weapon_1.weapon_name
	%ItemName2.text = weapon_2.weapon_name
	%ItemName3.text = weapon_3.weapon_name
	

func update_money():
	$Money.text = str(player_gold)
func _on_reroll_pressed():
	if player_gold >=5:
		player_gold-=5
		store_roll()
		update_money()


	else:
		print("pobre y panza")
