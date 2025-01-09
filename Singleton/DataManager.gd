extends Node

const DATA_FILE: String = "user://GAMEDATA.dat"
const STORIES_FILE: String = "res://stories.dat"
var stories_dict : Dictionary = {}

var high_score : Dictionary = {
	str(GameManager.Difficulty.EASY) : 0,
	str(GameManager.Difficulty.MEDIUM) : 0,
	str(GameManager.Difficulty.HARD) : 0,
}

const BALLOON_FILES = [
	preload("res://Assets/Balloons/balloon_form_1_1.png"),
	preload("res://Assets/Balloons/balloon_form_1_13.png"),
	preload("res://Assets/Balloons/balloon_form_1_16.png"),
	preload("res://Assets/Balloons/balloon_form_1_20.png"),
	preload("res://Assets/Balloons/balloon_form_1_24.png"),
	preload("res://Assets/Balloons/balloon_form_1_27.png"),
	preload("res://Assets/Balloons/balloon_form_1_28.png"),
	preload("res://Assets/Balloons/balloon_form_1_31.png"),
	preload("res://Assets/Balloons/balloon_form_1_34.png"),
	preload("res://Assets/Balloons/balloon_form_1_8.png")
]

func _ready():
	load_game_data()
	load_stories_data()

func reset_game_data() -> void:
	high_score = {
		str(GameManager.Difficulty.EASY) : 0,
		str(GameManager.Difficulty.MEDIUM) : 0,
		str(GameManager.Difficulty.HARD) : 0,
	}
	save_game_data()

func save_game_data() -> void:
	var file = FileAccess.open(DATA_FILE, FileAccess.WRITE)
	var data : Dictionary = {
		"LOCAL_KEY": TranslationServer.get_locale(),
	}
	data["HIGH_SCORE"] = high_score
	file.store_string(JSON.stringify(data))

func load_game_data() -> void:
	if !FileAccess.file_exists(DATA_FILE):
		return
		
	var file = FileAccess.open(DATA_FILE, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text()) 
	
	if data == null:
		return
	
	if "LOCAL_KEY" in data:
		TranslationServer.set_locale(data["LOCAL_KEY"])

	if "HIGH_SCORE" in data:
		high_score = data["HIGH_SCORE"]

func load_stories_data() -> void:
	if !FileAccess.file_exists(STORIES_FILE):
		print("No stories file found.")
		return
		
	var file = FileAccess.open(STORIES_FILE, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text()) 
	
	if data == null:
		print("Error parsing stories file.")
		return
	
	for lang_key in data.keys():
		for diff_key in data[lang_key].keys():
			if diff_key == "EASY":
				data[lang_key][GameManager.Difficulty.EASY] = data[lang_key][diff_key]
				data[lang_key].erase(diff_key)
			elif diff_key == "MEDIUM":
				data[lang_key][GameManager.Difficulty.MEDIUM] = data[lang_key][diff_key]
				data[lang_key].erase(diff_key)
			elif diff_key == "HARD":
				data[lang_key][GameManager.Difficulty.HARD] = data[lang_key][diff_key]
				data[lang_key].erase(diff_key)

	stories_dict = data

func get_balloon_files() -> Array:
	return BALLOON_FILES

func pick_random_balloon() -> String:
	return BALLOON_FILES[randi_range(0, BALLOON_FILES.size() - 1)]
