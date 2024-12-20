extends Control

func _ready():
	#TranslationServer.set_locale("it")
	$VBoxContainer/Titolo.text = tr("KEY_TITLE")
	$VBoxContainer/HBoxContainer/Titolo2.text = tr("KEY_DIFF_LABEL")
	$VBoxContainer/HBoxContainer/MarginContainer3/Facile.text = tr("KEY_EASY")
	$VBoxContainer/HBoxContainer/MarginContainer4/Intermedio.text = tr("KEY_MED")
	$VBoxContainer/HBoxContainer/MarginContainer5/Difficile.text = tr("KEY_HARD")
	
	
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
	GameManager.load_start_screen()


func _on_lang_it_button_pressed():
	TranslationServer.set_locale("it")
	GameManager.load_start_screen()
