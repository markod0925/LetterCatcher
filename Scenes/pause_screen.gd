extends Control

func _on_restart_button_pressed():
	GameManager.PlayerScore = 0
	GameManager.actual_level = 1
	GameManager.load_start_screen()
