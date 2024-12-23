extends Control

func _ready():
	#TranslationServer.set_locale("it")
	DataManager.load_game_data()
	$VBoxContainer/Titolo.text = tr("KEY_TITLE").to_upper()
	$VBoxContainer/HBoxContainer/Titolo2.text = tr("KEY_DIFF_LABEL")
	$VBoxContainer/HBoxContainer/MarginContainer3/Facile.text = tr("KEY_EASY").to_upper()
	$VBoxContainer/HBoxContainer/MarginContainer4/Intermedio.text = tr("KEY_MED").to_upper()
	$VBoxContainer/HBoxContainer/MarginContainer5/Difficile.text = tr("KEY_HARD").to_upper()
	
	
func _on_facile_pressed():
	GameManager.actual_difficulty = GameManager.Difficulty.EASY
	GameManager.start_new_game()


func _on_intermedio_pressed():
	GameManager.actual_difficulty = GameManager.Difficulty.MEDIUM
	GameManager.start_new_game()


func _on_difficile_pressed():
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
