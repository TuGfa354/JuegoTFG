extends Node2D
func _ready():
	load_game()

func save():
	#TODO Use actual data, not static strings
	#TODO Check how it can update in-game data. On playlist, part 2
	var save_dict={
		"score" : 1000,
		"username": "Santino",
	}
	return save_dict

func save_game():
	var save_game = FileAccess.open_encrypted_with_pass("user://savegame.save", FileAccess.WRITE, "password")
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		print("file does not exist")
		return
	var save_game = FileAccess.open_encrypted_with_pass("user://savegame.save", FileAccess.READ, "password")
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		print(node_data)
