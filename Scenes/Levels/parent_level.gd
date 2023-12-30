extends Node2D
class_name ParentLevel
var spell_scene: PackedScene = preload("res://Scenes/Projectiles/spell.tscn")

func _ready():
	for mage in get_tree().get_nodes_in_group("Mages"):
		mage.connect("spell", on_mage_spell)


func on_mage_spell(pos, direction):
	create_spell(pos, direction)

func create_spell(pos, direction):
	var spell = spell_scene.instantiate() as Area2D
	spell.position = pos
	spell.rotation_degrees = rad_to_deg(direction.angle()) + 90
	spell.direction = direction
	$Projectiles.add_child(spell)

