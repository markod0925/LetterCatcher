extends Control

@onready var highscore = $Highscore

func set_highscore() -> void:
	highscore.text = "PUNTEGGIO: %s" %str(GameManager.PlayerScore).pad_zeros(5)
