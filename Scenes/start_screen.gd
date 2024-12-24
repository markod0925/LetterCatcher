extends Control

func _ready():
	#TranslationServer.set_locale("it")
	DataManager.load_game_data()
	$VBoxContainer/Titolo.text = tr("KEY_TITLE").to_upper()
	$VBoxContainer/HBoxContainer/VBoxContainer/Titolo2.text = tr("KEY_DIFF_LABEL")
	$VBoxContainer/HBoxContainer/MarginContainer3/VBoxContainer/Easy.text = tr("KEY_EASY").to_upper()
	$VBoxContainer/HBoxContainer/MarginContainer4/VBoxContainer/Medium.text = tr("KEY_MED").to_upper()
	$VBoxContainer/HBoxContainer/MarginContainer5/VBoxContainer/Hard.text = tr("KEY_HARD").to_upper()
	$VBoxContainer/HBoxContainer/MarginContainer3/VBoxContainer/EasyRecord.text = str(DataManager.high_score[str(GameManager.Difficulty.EASY)]).pad_zeros(5)
	$VBoxContainer/HBoxContainer/MarginContainer4/VBoxContainer/MidRecord.text = str(DataManager.high_score[str(GameManager.Difficulty.MEDIUM)]).pad_zeros(5)
	$VBoxContainer/HBoxContainer/MarginContainer5/VBoxContainer/HardRecord.text = str(DataManager.high_score[str(GameManager.Difficulty.HARD)]).pad_zeros(5)
	
func _on_easy_pressed():
	GameManager.actual_difficulty = GameManager.Difficulty.EASY
	GameManager.start_new_game()


func _on_medium_pressed():
	GameManager.actual_difficulty = GameManager.Difficulty.MEDIUM
	GameManager.start_new_game()


func _on_hard_pressed():
	GameManager.actual_difficulty = GameManager.Difficulty.HARD
	GameManager.start_new_game()


func _on_lang_en_button_pressed():
	TranslationServer.set_locale("en")
	DataManager.save_game_data()
	GameManager.load_start_screen()


func _on_lang_it_button_pressed():
	TranslationServer.set_locale("it")
	DataManager.save_game_data()
	GameManager.load_start_screen()


func _on_lang_es_button_pressed():
	TranslationServer.set_locale("es")
	DataManager.save_game_data()
	GameManager.load_start_screen()
