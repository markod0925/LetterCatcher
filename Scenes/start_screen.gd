extends Control

func _ready():
	TranslationServer.set_locale("en")
	DataManager.load_game_data()
	$VBoxContainer/Titolo.text = tr("KEY_TITLE").to_upper()
	$VBoxContainer/HBoxContainer/VBoxContainer/Titolo2.text = tr("KEY_DIFF_LABEL")
	$VBoxContainer/HBoxContainer/MarginContainer3/VBoxContainer/Easy.text = tr("KEY_EASY").to_upper()
	$VBoxContainer/HBoxContainer/MarginContainer4/VBoxContainer/Medium.text = tr("KEY_MED").to_upper()
	$VBoxContainer/HBoxContainer/MarginContainer5/VBoxContainer/Hard.text = tr("KEY_HARD").to_upper()
	$VBoxContainer/HBoxContainer/MarginContainer3/VBoxContainer/EasyRecord.text = str(DataManager.high_score[str(GameManager.Difficulty.EASY)]).pad_zeros(5)
	$VBoxContainer/HBoxContainer/MarginContainer4/VBoxContainer/MidRecord.text = str(DataManager.high_score[str(GameManager.Difficulty.MEDIUM)]).pad_zeros(5)
	$VBoxContainer/HBoxContainer/MarginContainer5/VBoxContainer/HardRecord.text = str(DataManager.high_score[str(GameManager.Difficulty.HARD)]).pad_zeros(5)
	$MarginContainer2/VBoxContainer2/ResetButton.text = tr("KEY_RESET").to_upper()
	$MarginContainer2/VBoxContainer2/ColorBlindMode.text = tr("KEY_BLINDCOLOR").to_upper()
	$ColorBlindCorrection.material.set_shader_parameter("mode", GameManager.color_blind_mode)
	SoundManager.play_music_random($BGMusic, "START")


func _on_easy_pressed():
	GameManager.actual_difficulty = GameManager.Difficulty.EASY
	GameManager.start_new_game()


func _on_medium_pressed():
	GameManager.actual_difficulty = GameManager.Difficulty.MEDIUM
	GameManager.start_new_game()


func _on_hard_pressed():
	GameManager.actual_difficulty = GameManager.Difficulty.HARD
	GameManager.start_new_game()


func _save_and_load() -> void:
	GameManager.reset_story_list()
	DataManager.save_game_data()
	GameManager.load_start_screen()


func _on_lang_en_button_pressed():
	TranslationServer.set_locale("en")
	_save_and_load()

func _on_lang_it_button_pressed():
	TranslationServer.set_locale("it")
	_save_and_load()

func _on_lang_es_button_pressed():
	TranslationServer.set_locale("es")
	_save_and_load()

func _on_lang_de_button_pressed():
	TranslationServer.set_locale("de")
	_save_and_load()

func _on_lang_fr_button_pressed():
	TranslationServer.set_locale("fr")
	_save_and_load()

func _on_reset_button_pressed():
	DataManager.reset_game_data()
	_save_and_load()

func _on_color_blind_mode_pressed():
	if GameManager.color_blind_mode == 3:
		GameManager.color_blind_mode = 0
	else:
		GameManager.color_blind_mode = GameManager.color_blind_mode + 1
	$ColorBlindCorrection.material.set_shader_parameter("mode", GameManager.color_blind_mode)
	_save_and_load()
