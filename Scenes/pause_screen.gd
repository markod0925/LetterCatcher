extends Control

func _ready():
	$MarginContainer/VBoxContainer/Label.text = tr("KEY_PAUSE_TITLE").to_upper()
	$MarginContainer/VBoxContainer/Label2.text = tr("KEY_PAUSE_MSG").to_upper()
	$MarginContainer/VBoxContainer/RestartButton.text = tr("KEY_RESTART_BUTTON")
	
	
func _on_restart_button_pressed():
	GameManager.PlayerScore = 0
	GameManager.actual_level = 1
	DataManager.save_game_data()
	GameManager.load_start_screen()
