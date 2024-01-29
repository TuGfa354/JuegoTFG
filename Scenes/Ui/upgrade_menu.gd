extends Control
signal resume
@export var weapons: Array[PackedScene]= []
@onready var player_weapons = get_tree().get_first_node_in_group("player").get_child(1)
var player_gold:int 
var weapon_1
var weapon_2
var weapon_3

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
	weapon_1 = weapons.pick_random().instantiate()
	weapon_2 = weapons.pick_random().instantiate()
	weapon_3 = weapons.pick_random().instantiate()
	#print(weapon_1.description)
	#print(weapon_2.description)
	#print(weapon_3.description)
	%Item1.texture = weapon_1.weapon_info.weapon_sprite
	%Item2.texture = weapon_2.weapon_info.weapon_sprite
	%Item3.texture = weapon_3.weapon_info.weapon_sprite
	#%ItemDescription1.text = weapon_1.weapon_info.description
	#%ItemDescription2.text = weapon_2.description
	#%ItemDescription3.text = weapon_3.description
	%Price1.text = str(weapon_1.weapon_info.price)
	%Price2.text = str(weapon_2.weapon_info.price)
	%Price3.text = str(weapon_3.weapon_info.price)
	%ItemName1.text = weapon_1.weapon_info.weapon_name
	%ItemName2.text = weapon_2.weapon_info.weapon_name
	%ItemName3.text = weapon_3.weapon_info.weapon_name
	$StoreMargin/StoreGrid/IndividualStoreMargin.visible = true
	$StoreMargin/StoreGrid/IndividualStoreMargin2.visible = true
	$StoreMargin/StoreGrid/IndividualStoreMargin3.visible = true
	

func update_money():
	$Money.text = str(player_gold)
func _on_reroll_pressed():
	if player_gold >=3:
		player_gold-=3
		store_roll()
		update_money()


	else:
		print("pobre y panza")


func _on_buy_pressed():
	var weapon_slot = null
	for i in player_weapons.get_child_count():
		if player_weapons.get_child(i).get_child_count()==0:
			weapon_slot = player_weapons.get_child(i)
	if player_gold >= weapon_1.weapon_info.price:
		if weapon_slot != null:
			weapon_slot.add_child(weapon_1)
			player_gold-=weapon_1.weapon_info.price
			update_money()
			hide_box(1)


func _on_buy_2_pressed():
	var weapon_slot = null
	for i in player_weapons.get_child_count():
		if player_weapons.get_child(i).get_child_count()==0:
			weapon_slot = player_weapons.get_child(i)
	if player_gold >= weapon_2.weapon_info.price:
		if weapon_slot != null:
			weapon_slot.add_child(weapon_2)
			player_gold-=weapon_2.weapon_info.price
			update_money()
			hide_box(2)


func _on_buy_3_pressed():
	var weapon_slot = null
	for i in player_weapons.get_child_count():
		if player_weapons.get_child(i).get_child_count()==0:
			weapon_slot = player_weapons.get_child(i)
	if player_gold >= weapon_3.weapon_info.price:
		if weapon_slot != null:
			print(weapon_3)
			print(weapon_slot)
			weapon_slot.add_child(weapon_3)
			player_gold-=weapon_3.weapon_info.price
			update_money()
			hide_box(3)

func hide_box(box_number):
	match box_number:
		1:
			$StoreMargin/StoreGrid/IndividualStoreMargin.visible = false
			%Continue.grab_focus()
		2:
			$StoreMargin/StoreGrid/IndividualStoreMargin2.visible = false
			%Continue.grab_focus()
		3:
			$StoreMargin/StoreGrid/IndividualStoreMargin3.visible = false
			%Continue.grab_focus()
