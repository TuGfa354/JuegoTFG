extends Control
signal resume
@export var weapons: Array[PackedScene]= []
@onready var player_weapons = get_tree().get_first_node_in_group("player").get_child(1)
var player_gold:int 
var weapon_1
var weapon_2
var weapon_3
#TODO cuando le doy a la derecha en el ccandado de la derecha me lleva a reroll, cuando le doy a reroll a la izq mme lleva a la llave
#TODO cambiar las stats a botones para poder leer lo que hacen
func _ready():
	
	TranslationServer.set_locale(Globals.current_language)
	translate()
#region functions

func translate():
	%Continue.text= tr("continue")
	%Buy.text = tr("buy")
	%Buy2.text = tr("buy")
	%Buy3.text = tr("buy")
	%Objects.text = tr("objects")
	%Weapons.text = tr("weapons")
	%Reroll.text = tr("reroll")
	%max_hp.text = tr('max_hp')
	%attack.text = tr('attack')
	%defence.text = tr('defence')
	%speed.text = tr('speed')
	%attack_speed.text = tr('attack_speed')
	%hp_regeneration.text = tr('hp_regeneration')
	%life_steal.text = tr('life_steal')
	%range.text = tr('range')
	%crit_rate.text = tr('crit_rate')
	%crit_damage.text = tr('crit_damage')
#func _process(delta):
	#print(visible)
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
	%Background1.visible = true
	%Background2.visible = true
	%Background3.visible = true
	%Lock1.visible = true
	%Lock2.visible = true
	%Lock3.visible = true
	update_sprites()

func update_money():
	$Money.text = str(Globals.player_gold)
func hide_box(box_number):
	update_sprites()
	match box_number:
		1:
			%Background1.visible = false
			%Lock1.visible = false
			%Continue.grab_focus()
		2:
			%Background2.visible = false
			%Lock2.visible = false
			%Continue.grab_focus()
		3:
			%Background3.visible = false
			%Lock3.visible = false
			%Continue.grab_focus()

func update_sprites():
	for i in player_weapons.get_child_count():
		if player_weapons.get_child(i).get_child_count()==1:
			#var full_path = sprite_path+str(i)
			var weapon = player_weapons.get_child(i).get_child(0)
			var texture_slot = $WeaponsMargin/WeaponsGrid.get_child(i).get_child(0)
			texture_slot.texture = weapon.weapon_info.weapon_sprite

func buy_weapon(n):
	var weapon_slot = null
	for i in player_weapons.get_child_count():
		if player_weapons.get_child(i).get_child_count()==0:
			weapon_slot = player_weapons.get_child(i)
	match n:
		1:
			if Globals.player_gold >= weapon_1.weapon_info.price:
				if weapon_slot != null:
					weapon_slot.add_child(weapon_1)
					Globals.player_gold-=weapon_1.weapon_info.price
					update_money()
					hide_box(1)
		2:
			if Globals.player_gold >= weapon_2.weapon_info.price:
				if weapon_slot != null:
					weapon_slot.add_child(weapon_2)
					Globals.player_gold-=weapon_2.weapon_info.price
					update_money()
					hide_box(2)
		3:
			if Globals.player_gold >= weapon_3.weapon_info.price:
				if weapon_slot != null:
					weapon_slot.add_child(weapon_3)
					Globals.player_gold-=weapon_3.weapon_info.price
					update_money()
					hide_box(3)

#endregion

#region signals


func _on_continue_pressed():
	resume.emit()

func _on_visibility_changed():
	if get_parent().visible == true:

		update_money()
		store_roll()

func _on_reroll_pressed():
	if Globals.player_gold >=3:
		Globals.player_gold-=3
		store_roll()
		update_money()


	else:
		print("pobre y panza")


func _on_buy_pressed():
	buy_weapon(1)



func _on_buy_2_pressed():
	buy_weapon(2)


func _on_buy_3_pressed():
	buy_weapon(3)




func _on_weapon_border_focus_entered():
	%WeaponBorder.modulate = 'ff4d92'


func _on_weapon_border_2_focus_entered():
	%WeaponBorder2.modulate = 'ff4d92'


func _on_weapon_border_3_focus_entered():
	%WeaponBorder3.modulate = 'ff4d92'


func _on_weapon_border_4_focus_entered():
	%WeaponBorder4.modulate = 'ff4d92'


func _on_weapon_border_5_focus_entered():
	%WeaponBorder5.modulate = 'ff4d92'


func _on_weapon_border_6_focus_entered():
	%WeaponBorder6.modulate = 'ff4d92'


func _on_weapon_border_focus_exited():
	%WeaponBorder.modulate = 'ffffff'


func _on_weapon_border_2_focus_exited():
	%WeaponBorder2.modulate = 'ffffff'


func _on_weapon_border_3_focus_exited():
	%WeaponBorder3.modulate = 'ffffff'


func _on_weapon_border_4_focus_exited():
	%WeaponBorder4.modulate = 'ffffff'


func _on_weapon_border_5_focus_exited():
	%WeaponBorder5.modulate = 'ffffff'


func _on_weapon_border_6_focus_exited():
	%WeaponBorder6.modulate = 'ffffff'


func _on_object_border_focus_entered():
	%ObjectBorder.modulate = 'ff4d92'


func _on_object_border_focus_exited():
	%ObjectBorder.modulate = 'ffffff'


func _on_object_border_2_focus_entered():
	%ObjectBorder2.modulate = 'ff4d92'


func _on_object_border_2_focus_exited():
	%ObjectBorder2.modulate = 'ffffff'


func _on_object_border_3_focus_entered():
	%ObjectBorder3.modulate = 'ff4d92'


func _on_object_border_3_focus_exited():
	%ObjectBorder3.modulate = 'ffffff'


func _on_object_border_4_focus_entered():
	%ObjectBorder4.modulate = 'ff4d92'


func _on_object_border_4_focus_exited():
	%ObjectBorder4.modulate = 'ffffff'


func _on_object_border_5_focus_entered():
	%ObjectBorder5.modulate = 'ff4d92'


func _on_object_border_5_focus_exited():
	%ObjectBorder5.modulate = 'ffffff'


func _on_object_border_6_focus_entered():
	%ObjectBorder6.modulate = 'ff4d92'


func _on_object_border_6_focus_exited():
	%ObjectBorder6.modulate = 'ffffff'

#endregion
