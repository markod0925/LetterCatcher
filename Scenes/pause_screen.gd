extends Control

func _ready():
	$MarginContainer/VBoxContainer/Label.text = tr("KEY_PAUSE_TITLE")
	$MarginContainer/VBoxContainer/Label2.text = tr("KEY_PAUSE_MSG")
	$MarginContainer/VBoxContainer/RestartButton.text = tr("KEY_RESTART_BUTTON")
	
	
func _on_restart_button_pressed():
	GameManager.PlayerScore = 0
	GameManager.actual_level = 1
	GameManager.load_start_screen()
