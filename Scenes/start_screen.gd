extends Control


func _on_facile_pressed():
	GameManager.actual_difficulty = GameManager.Difficulty.EASY
	GameManager.start_new_game()

func _on_intermedio_pressed():
	GameManager.actual_difficulty = GameManager.Difficulty.MEDIUM
	GameManager.start_new_game()

func _on_difficile_pressed():
	GameManager.actual_difficulty = GameManager.Difficulty.HARD
	GameManager.start_new_game()
