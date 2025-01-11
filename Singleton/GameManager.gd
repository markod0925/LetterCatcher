extends Node

const ERROR_CODE = "ErrA3Vcs5"

var PlayerScore : int = 0
var actual_level : int = 1
var actual_difficulty : Difficulty = Difficulty.EASY
var POPUP_SCENE : PackedScene = preload("res://Scenes/popup/popup.tscn")
var local_lang = "it"
var Boss_activated : bool = false
var _actual_story_list : Dictionary = {}
var color_blind_mode : int = 0

enum Difficulty {EASY, MEDIUM, HARD}

# Definisci per ogni livello di difficoltà il tempo di attesa tra un lettera e l'altra, e la velocità di movimento delle lettere
var difficulty_dict = {
	Difficulty.EASY: {"wait_time": 2.0, "letter_speed": 10.0, "failure_rate": 1.0/0.25, "spawn_enemies_rate": 5.0, "boss_level": 5},
	Difficulty.MEDIUM: {"wait_time": 1.0, "letter_speed": 20.0, "failure_rate": 1.0/0.15, "spawn_enemies_rate": 2.5, "boss_level": 10},
	Difficulty.HARD: {"wait_time": 0.5, "letter_speed": 40.0, "failure_rate": 1.0/0.02, "spawn_enemies_rate": 1.5, "boss_level": 15}
}

# Functions list

func add_child_deffered(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)


func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deffered", child_to_add)
	

func load_main_scene() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func load_start_screen() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func get_wait_time() -> float:
	return clamp(difficulty_dict[actual_difficulty]["wait_time"], 0.21, 2.0)


func get_spawn_time() -> float:
	return clamp(difficulty_dict[actual_difficulty]["spawn_enemies_rate"], 1.0, 10.0)


func get_letter_speed() -> float:
	return difficulty_dict[actual_difficulty]["letter_speed"]


func get_failure_rate() -> float:
	return difficulty_dict[actual_difficulty]["failure_rate"]


func reset_story_list() -> void:
	_actual_story_list = {}
	

func get_story() -> Dictionary:
	if _actual_story_list.size() == 0:
		if TranslationServer.get_locale() in DataManager.stories_dict.keys():
			_actual_story_list = DataManager.stories_dict[TranslationServer.get_locale()][actual_difficulty]
		if _actual_story_list.size() == 0:
			print("No stories found for the selected language and difficulty.")
			return {"title": ERROR_CODE, "text": ""}
	var _rand_number = randi_range(0, _actual_story_list.size()-1)
	var _story_key = _actual_story_list.keys()[_rand_number]
	var _story_text = _actual_story_list[_story_key]
	_actual_story_list.erase(_story_key)
	return {"title": _story_key, "text": _story_text}


func start_new_game() -> void:
	PlayerScore = 0
	actual_level = 1
	Boss_activated = false
	load_main_scene()


func load_new_level() -> void:
	DataManager.save_game_data()
	actual_level = actual_level + 1
	if Boss_activated:
		Boss_activated = false
		load_start_screen()
	else:
		if actual_level >= difficulty_dict[actual_difficulty]["boss_level"]:
			Boss_activated = true
		load_main_scene()


func update_score(pos: Vector2, value: int) -> void:
	if value > 0:
		create_info_popup_scene(pos, "+%s" %value)
	else:
		create_info_popup_scene(pos, "%s" %value)
	PlayerScore = clampi(PlayerScore + value, 0, 99999)
	if PlayerScore >= DataManager.high_score[str(actual_difficulty)]:
		DataManager.high_score[str(actual_difficulty)] = PlayerScore


func create_info_popup_scene(pos: Vector2, info: String) -> void:
	var new_popup = POPUP_SCENE.instantiate()
	new_popup.setup(pos, info)
	call_add_child(new_popup)
