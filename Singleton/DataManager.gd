extends Node

const DATA_FILE: String = "user://GAMEDATA.dat"

var high_score : Dictionary = {
	str(GameManager.Difficulty.EASY) : 0,
	str(GameManager.Difficulty.MEDIUM) : 0,
	str(GameManager.Difficulty.HARD) : 0,
}

func _ready():
	load_game_data()


func save_game_data() -> void:
	var file = FileAccess.open(DATA_FILE, FileAccess.WRITE)
	var data : Dictionary = {
		"LOCAL_KEY": TranslationServer.get_locale(),
	}
	data["HIGH_SCORE"] = high_score
	#var _unlvldata : Dictionary
	#for lv in range(1, GameManager.TOTAL_LEVELS + 1):
		#_unlvldata["level_%s" %lv] = _unlocked_level[lv-1]
	#data[UNLOCK_KEY] = _unlvldata
	
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
	#print(high_score)
		
	#if UNLOCK_KEY in data:
		#for lv in range(1, GameManager.TOTAL_LEVELS + 1):
			#if data[UNLOCK_KEY]["level_%s" %lv] == null: 
				#_unlocked_level[lv-1] = false
			#else:
				#_unlocked_level[lv-1] = data[UNLOCK_KEY]["level_%s" %lv]
